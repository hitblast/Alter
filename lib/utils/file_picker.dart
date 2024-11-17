import 'package:file_selector/file_selector.dart';
import 'dart:io';

Future<XFile?> pickApplication() async {
  final XFile? file = await openFile(initialDirectory: '/Applications');
  return file;
}

Future<bool?> ifAppIsSystemApplication(String path) async {
  // first strip the path to get the application name, usually at the end of the path
  // then, check if the application also exists in /System/Applications

  final List<String> pathParts = path.split('/');
  final String appName = pathParts[pathParts.length - 1];

  // check if the application exists in /System/Applications
  final Directory systemApplications = Directory('/System/Applications');
  final List<FileSystemEntity> systemApplicationsList =
      await systemApplications.list().toList();

  for (final FileSystemEntity systemApplication in systemApplicationsList) {
    if (systemApplication.path.contains(appName)) {
      return true;
    }
  }
  return false;
}
