import 'package:alter/models/app.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  static late Isar isar;

  // Initialize the Isar database.
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [AppSchema],
      directory: dir.path,
    );
  }

  // Get current list of apps available to Alter for modification.
  final List<App> currentApps = [];

  /*

  QOL functions.

  */

  Future<bool> isAppInDatabase(String path) async {
    final app = await isar.apps.where().filter().pathEqualTo(path).findFirst();
    return app != null;
  }

  /*

  Basic CRUD operations for the database.

  */

  // Add an app to the database.
  Future<void> addApp(
      String pathToAssign, String customIconPathToAssign) async {
    final newApp = App()
      ..path = pathToAssign
      ..customIconPath = customIconPathToAssign;

    await isar.writeTxn(() => isar.apps.put(newApp));
    await fetchApps();
  }

  // Fetch the apps from the database.
  Future<void> fetchApps() async {
    List<App> fetchedApps = await isar.apps.where().findAll();
    currentApps.clear();
    currentApps.addAll(fetchedApps);
  }

  // Update the app in the database.
  Future<void> updateAppIcon(int id, String newCustomIconPath) async {
    final existingApp = await isar.apps.get(id);

    if (existingApp != null) {
      existingApp.customIconPath = newCustomIconPath;
      await isar.writeTxn(() => isar.apps.put(existingApp));
      await fetchApps();
    }
  }

  // Delete an app from the database.
  Future<void> deleteApp(int id) async {
    await isar.writeTxn(() => isar.apps.delete(id));
    await fetchApps();
  }
}
