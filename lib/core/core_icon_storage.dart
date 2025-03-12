// Imports.
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// Helper to get the AppIcons directory.
Future<Directory> _getAppIconsDirectory() async {
  final appSupportDir = await getApplicationSupportDirectory();
  final iconsDir = Directory(path.join(appSupportDir.path, 'AppIcons'));
  if (!(await iconsDir.exists())) {
    await iconsDir.create(recursive: true);
  }
  return iconsDir;
}

// Helper to construct the stored file path for an app.
String _getStoredFilePath(String appPath, Directory iconsDir) {
  final appName = path.basenameWithoutExtension(appPath);
  return path.join(iconsDir.path, '${appName}_custom.icns');
}

/// Saves the final custom icon into the AppIcons folder
/// (inside the application support directory).
/// Returns the file's path.
Future<String> storeCustomIconInStorage(
    String appliedIconPath, String appPath) async {
  final iconsDir = await _getAppIconsDirectory();
  final storedFilePath = _getStoredFilePath(appPath, iconsDir);

  await File(appliedIconPath).copy(storedFilePath);
  debugPrint('Stored icon at $storedFilePath');

  return storedFilePath;
}

/// Get the stored icon for an app path.
Future<String?> getStoredIconForAppPath(String appPath) async {
  final iconsDir = await _getAppIconsDirectory();
  final storedFilePath = _getStoredFilePath(appPath, iconsDir);

  if (await File(storedFilePath).exists()) {
    return storedFilePath;
  }
  return null;
}

/// Delete the stored icon for an app path.
Future<void> deleteStoredIconForAppPath(String appPath) async {
  final storedIconPath = await getStoredIconForAppPath(appPath);
  if (storedIconPath != null) {
    debugPrint('Deleting stored icon at $storedIconPath');
    await File(storedIconPath).delete();
  }
}
