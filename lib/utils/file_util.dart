// First-party imports.
import 'dart:io';

// Third-party imports.
import 'package:file_selector/file_selector.dart';
import 'package:process_run/process_run.dart';

/*

File-picker functions for Alter.

*/

/// Open a macOS-native file picker window for picking applications inside the Applications folder.
Future<XFile?> pickApplication() async {
  final XFile? file = await openFile(initialDirectory: '/Applications');
  return file;
}

/// Open the custom icon of the application using Preview.
Future<void> openFileInPreview(String path) async {
  var shell = Shell();
  await shell.run('open -a Preview "$path"');
}

/// Open a macOS-native file picker window for picking .icns and .png (coming) files for using as custom app icons.
Future<XFile?> pickIcon() async {
  final XFile? file = await openFile(acceptedTypeGroups: [
    const XTypeGroup(label: 'Icons', extensions: ['icns'])
  ]);
  return file;
}

/// Do cutlery on an application's absolute path and extract the name of it.
String getAppNameFromPath(String path) {
  final List<String> pathParts = path.split('/');
  final String appName = pathParts[pathParts.length - 1];

  return appName;
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
