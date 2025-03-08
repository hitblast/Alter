// First-party imports.
import 'dart:io';
import 'package:flutter/foundation.dart';

// Third-party imports.
import 'package:file_selector/file_selector.dart';
import 'package:process_run/process_run.dart';

/*

Basic functions for using inside Alter.

*/

/// Open the custom icon of the application using Preview.
Future<void> openFileInPreview(String path) async {
  final shell = Shell();
  await shell.run('open -a Preview "$path"');
}

/// Open a macOS-native file picker window for picking .icns and .png (coming) files for using as custom app icons.
Future<XFile?> pickIcon() async {
  final XFile? file = await openFile(acceptedTypeGroups: [
    const XTypeGroup(label: 'Icons', extensions: ['icns', 'png'])
  ]);
  debugPrint("Chosen icon: ${file?.name}");
  return file;
}

/// Strip the application name from a path.
/// Optionally, use `withoutExtension` to only return the app's branding name.
String getAppNameFromPath(String path, [bool withoutExtension = false]) {
  final String appName = path.split(Platform.pathSeparator).last;
  return withoutExtension ? appName.split('.').first : appName;
}

/// Function to determine if an application is a system application.
Future<bool> ifAppIsSystemApplication(String path) async {
  String appName = getAppNameFromPath(path);

  // Directories which hold the system applications on macOS.
  final List<String> systemApplicationDirs = [
    '/System/Applications',
    '/System/Applications/Utilities',
  ];

  for (final String systemDirPath in systemApplicationDirs) {
    final Directory systemDirectory = Directory(systemDirPath);

    if (await systemDirectory.exists()) {
      final List<FileSystemEntity> systemApplicationsList =
          await systemDirectory.list().toList();

      for (final FileSystemEntity systemApplication in systemApplicationsList) {
        if (systemApplication.path.contains(appName)) {
          return true;
        }
      }
    }
  }
  return false;
}
