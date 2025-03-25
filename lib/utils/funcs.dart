// First-party imports.
import 'dart:io';
import 'package:flutter/foundation.dart';

// Third-party imports.
import 'package:path/path.dart' as path;
import 'package:file_selector/file_selector.dart';
import 'package:process_run/shell.dart';

/*

Basic functions for using inside Alter.

*/

/// Kill handy system services if needed.
Future<void> killSystemServices() async {
  final shell = Shell(throwOnError: false);
  await shell.run('/usr/bin/killall Dock Finder SystemUIServer');
}

/// Open a path using Preview.
/// Returns a boolean indicating if the file has been opened.
Future<bool> openFileInPreview(String path) async {
  final shell = Shell();

  try {
    await shell.run('/usr/bin/open -a Preview "$path"');
  } catch (_) {
    return false;
  }
  return true;
}

/// Open a macOS-native file picker window for picking .icns and .png (coming) files for using as custom app icons.
Future<XFile?> pickIcon() async {
  final XFile? file = await openFile(
    acceptedTypeGroups: [
      const XTypeGroup(label: 'Icons', extensions: ['icns', 'png']),
    ],
  );
  debugPrint("Chosen icon: ${file?.name}");
  return file;
}

/// Function to determine if an application is a system application.
Future<bool> ifAppIsSystemApplication(String appPath) async {
  String appName = path.basename(appPath);

  // Directories which hold the system applications on macOS.
  final List<String> systemApplicationDirs = [
    path.join('/', 'System', 'Applications'),
    path.join('/', 'System', 'Applications', 'Utilities'),
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
