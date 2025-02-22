// First-party imports.
import 'dart:io';
import 'package:flutter/foundation.dart';

// Third-party imports.
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// Local imports.
import 'package:alter/main.dart';
import 'package:alter/models/app_model.dart';

/*

Basic database utility functions.
These can be used independent of the provider.

*/

/// Returns a newly initialized Isar instance for an isolate.
Future<Isar> ensureDatabase() async {
  final applicationDocumentsDirectory = await getApplicationSupportDirectory();
  final dir = Directory('${applicationDocumentsDirectory.path}/AppList');

  // Create the database directory if it doesn't exist.
  if (!(await dir.exists())) {
    debugPrint("Database does not exist, creating one in ${dir.path}");
    await dir.create();
  }

  // Initialize an Isar database instance.
  final newIsarInstance = await Isar.open(
    [
      // The base schema for storing application data.
      AppSchema,
    ],
    directory: dir.path,
    name: 'alterAppListInstance',
    inspector: false,
  );
  debugPrint('Initialized database at path: ${newIsarInstance.path}');

  return newIsarInstance;
}

/// Checks if an app exists given its path.
Future<bool> appExistsByPath(String path) async {
  return await coreIsolateIsar.apps.filter().pathEqualTo(path).count() > 0;
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
    List<App> fetchedApps = await coreIsolateIsar.apps.where().findAll();
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
    final newApp = App()
      ..path = path
      ..customIconPath = customIconPath
      ..newCFBundleIconName = newCFBundleIconName
      ..newCFBundleIconFile = newCFBundleIconFile
      ..previousCFBundleIconName = previousCFBundleIconName
      ..previousCFBundleIconFile = previousCFBundleIconFile;

    await coreIsolateIsar.writeTxn(() => coreIsolateIsar.apps.put(newApp));
    await fetchApps();
  }

  /// Update the app in the database.
  Future<void> updateAppIcon(
    int id,
    String newCustomIconPath,
    String newCFBundleIconName,
    String newCFBundleIconFile,
  ) async {
    final existingApp = await coreIsolateIsar.apps.get(id);

    if (existingApp != null) {
      // Modify existing fields.
      existingApp.customIconPath = newCustomIconPath;
      existingApp.newCFBundleIconName = newCFBundleIconName;
      existingApp.newCFBundleIconFile = newCFBundleIconFile;

      await coreIsolateIsar
          .writeTxn(() => coreIsolateIsar.apps.put(existingApp));
      await fetchApps();
    }
  }

  /// Delete an app from the database.
  Future<void> deleteApp(int id) async {
    await coreIsolateIsar.writeTxn(() => coreIsolateIsar.apps.delete(id));
    await fetchApps();
  }

  /// Delete all apps from the database
  Future<void> deleteAllApps() async {
    for (final app in await coreIsolateIsar.apps.where().findAll()) {
      await coreIsolateIsar.writeTxn(() => coreIsolateIsar.apps.delete(app.id));
      await fetchApps();
    }
  }
}
