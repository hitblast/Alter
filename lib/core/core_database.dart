// Local imports.
import 'package:alter/objectbox.g.dart';
import 'package:alter/main.dart';
import 'package:alter/models/app_model.dart';

/*

Basic database utility functions.
These can be used independent of the provider.

*/

/// Checks if an app exists given its path.
Future<bool> appExistsByPath(String path) async {
  final query = (objectBox.appBox.query(App_.path.equals(path))
        ..order(App_.path))
      .build();
  final exists = await query.findFirstAsync() != null;
  query.close();
  return exists;
}

/// Core database class for Alter.
/// This interacts with the root isolate's Isar instance to manage and keep track of modified apps.
/// Note that background services must NOT use this class (if not modified to support multiple Isar
/// instances later on).
class AppDatabase {
  List<App> currentApps = [];

  /*

  Basic CRUD operations for the database.

  */

  /// Fetch the apps from the database.
  Future<void> fetchApps() async {
    List<App> fetchedApps = await objectBox.appBox.getAllAsync();
    currentApps.clear();
    currentApps = fetchedApps;
  }

  /// Get an app by its ID from the current list of apps.
  /// Returns null if the app does not exist.
  Future<App?> getAppById(int id) async {
    try {
      return currentApps.firstWhere((app) => app.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Add an app to the database.
  Future<void> addApp(
    String path,
    String customIconPath,
    String newCFBundleIconName,
    String newCFBundleIconFile,
    String previousCFBundleIconName,
    String previousCFBundleIconFile,
  ) async {
    final newApp = App(
      path: path,
      customIconPath: customIconPath,
      newCFBundleIconName: newCFBundleIconName,
      newCFBundleIconFile: newCFBundleIconFile,
      previousCFBundleIconName: previousCFBundleIconName,
      previousCFBundleIconFile: previousCFBundleIconFile,
    );

    await objectBox.appBox.putAsync(newApp);
    await fetchApps();
  }

  /// Update the app in the database.
  Future<void> updateAppIcon(
    int id,
    String newCustomIconPath,
    String newCFBundleIconName,
    String newCFBundleIconFile,
  ) async {
    final existingApp = await objectBox.appBox.getAsync(id);

    if (existingApp != null) {
      // Modify existing fields.
      existingApp.customIconPath = newCustomIconPath;
      existingApp.newCFBundleIconName = newCFBundleIconName;
      existingApp.newCFBundleIconFile = newCFBundleIconFile;

      await objectBox.appBox.put(existingApp);
      await fetchApps();
    }
  }

  /// Delete an app from the database.
  Future<void> deleteApp(int id) async {
    await objectBox.appBox.removeAsync(id);
    await fetchApps();
  }

  /// Delete all apps from the database
  Future<void> deleteAllApps() async {
    await objectBox.appBox.removeAllAsync();
  }
}
