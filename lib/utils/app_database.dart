// Third-party imports.
import 'package:isar/isar.dart';

// Local imports.
import 'package:alter/main.dart';
import 'package:alter/models/app.dart';

class AppDatabase {
  List<App> currentApps = [];

  /*

  Basic CRUD operations for the database.

  */

  // Fetch the apps from the database.
  Future<void> fetchApps() async {
    List<App> fetchedApps = await isar.apps.where().findAll();
    currentApps.clear();
    currentApps = fetchedApps;
  }

  // Add an app to the database.
  Future<void> addApp(
      String pathToAssign, String customIconPathToAssign) async {
    final newApp = App()
      ..path = pathToAssign
      ..customIconPath = customIconPathToAssign;

    await isar.writeTxn(() => isar.apps.put(newApp));
    await fetchApps();
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

  // Get all apps.
  Future<List<App>> getAllApps() async {
    return await isar.apps.where().findAll();
  }

  // Delete all apps.
  Future<void> deleteAllApps() async {
    for (final app in await getAllApps()) {
      await isar.writeTxn(() => isar.apps.delete(app.id));
      await fetchApps();
    }
  }
}
