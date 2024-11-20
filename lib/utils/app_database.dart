// Third-party imports.
import 'package:isar/isar.dart';

// Local imports.
import 'package:alter/main.dart';
import 'package:alter/models/app.dart';

class AppDatabase {
  final List<App> currentApps = [];

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
