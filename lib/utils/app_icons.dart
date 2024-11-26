// Third-party imports.
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:process_run/shell.dart';

// Local imports.
import 'package:alter/models/processed_command.dart';

// The function to set a custom icon for an app.
Future<ProcessedCommand?> setCustomIconForApp(
    String appPath, String userCustomIconPath) async {
  File userCustomIcon = File(userCustomIconPath);
  String userCustomIconName = userCustomIcon.path.split('/').last;

  // Copy the custom icon to the app's Resources folder for the app bundle to access it.
  // This also creates a new file with access to the customIcon variable.
  final customIcon = await userCustomIcon
      .copy('$appPath/Contents/Resources/$userCustomIconName');

  // Run the shell commands to set the custom icon for the app.
  var shell = Shell(throwOnError: true);
  final appBundleInfoPath = "$appPath/Contents/Info";

  // Store the previous icon values for backup.
  late String previousCFBundleIconName;
  late String previousCFBundleIconFile;

  // The shell script to set the custom icon for the app.
  try {
    previousCFBundleIconName =
        (await shell.run('defaults read $appBundleInfoPath CFBundleIconName'))
            .first
            .outText;
    previousCFBundleIconFile =
        (await shell.run('defaults read $appBundleInfoPath CFBundleIconFile'))
            .first
            .outText;

    await shell.run('''
      # Set the custom icon for the app.
      defaults write $appBundleInfoPath CFBundleIconFile "$userCustomIconName"
      defaults write $appBundleInfoPath CFBundleIconName "$userCustomIconName"

      # Touch the app to update the icon.
      touch $appPath

      # Force-sign the app since otherwise macOS will not allow the app to run.
      codesign --force --deep --sign - $appPath
      ''');
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }

  // Only for debugging purposes!
  // debugPrint(previousCFBundleIconName);
  // debugPrint(previousCFBundleIconFile);

  // Create an instance of the ProcessedCommand model and return it.
  return ProcessedCommand(
    customIconPath: customIcon.path,
    previousCFBundleIconFile: previousCFBundleIconFile,
    previousCFBundleIconName: previousCFBundleIconName,
  );
}
