// Third-party imports.
import 'package:isar/isar.dart';

// Local imports.
import 'package:alter/main.dart';
import 'package:alter/models/app.dart';

// Basic database utility functions.
Future<bool> appExistsByPath(String path) async {
  return await isar.apps.where().filter().pathEqualTo(path).count() > 0;
}

Future<List<App>> getAllApps() async {
  return await isar.apps.where().findAll();
}

// The database class for managing the apps.
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

  // Fetch an app by its ID.
  Future<App?> fetchAppById(int id) async {
    return await isar.apps.get(id);
  }

  // Add an app to the database.
  Future<void> addApp(
    String path,
    String customIconPath,
    String newCFBundleIconName,
    String newCFBundleIconFile,
    String previousCFBundleIconName,
    String previousCFBundleIconFile,
  ) async {
    final newApp = App()
      ..path = path
      ..customIconPath = customIconPath
      ..newCFBundleIconName = newCFBundleIconName
      ..newCFBundleIconFile = newCFBundleIconFile
      ..previousCFBundleIconName = previousCFBundleIconName
      ..previousCFBundleIconFile = previousCFBundleIconFile;

    await isar.writeTxn(() => isar.apps.put(newApp));
    await fetchApps();
  }

  // Update the app in the database.
  Future<void> updateAppIcon(
    int id,
    String newCustomIconPath,
    String newCFBundleIconName,
    String newCFBundleIconFile,
  ) async {
    final existingApp = await isar.apps.get(id);

    if (existingApp != null) {
      // Modify existing fields.
      existingApp.customIconPath = newCustomIconPath;
      existingApp.newCFBundleIconName = newCFBundleIconName;
      existingApp.newCFBundleIconFile = newCFBundleIconFile;

      await isar.writeTxn(() => isar.apps.put(existingApp));
      await fetchApps();
    }
  }

  // Delete an app from the database.
  Future<void> deleteApp(int id) async {
    await isar.writeTxn(() => isar.apps.delete(id));
    await fetchApps();
  }

  // Delete all apps.
  Future<void> deleteAllApps() async {
    for (final app in await getAllApps()) {
      await isar.writeTxn(() => isar.apps.delete(app.id));
      await fetchApps();
    }
  }
}
