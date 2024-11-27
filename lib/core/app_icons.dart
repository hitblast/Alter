// Third-party imports.
import 'dart:io';

import 'package:alter/models/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:process_run/shell.dart';

// Local imports.
import 'package:alter/models/processed_command.dart';

// The function to set a custom icon for an app.
Future<ProcessedCommand?> setCustomIconForApp(
    String appPath, String userCustomIconPath) async {
  final File userCustomIcon = File(userCustomIconPath);
  final String userCustomIconName = userCustomIconPath.split('/').last;

  // Copy the custom icon to the app's Resources folder for the app bundle to access it.
  // This also creates a new file with access to the customIcon variable.
  final File customIcon = await userCustomIcon
      .copy('$appPath/Contents/Resources/$userCustomIconName');

  // Run the shell commands to set the custom icon for the app.
  var shell = Shell(throwOnError: true);
  final String appBundleInfoPath = "$appPath/Contents/Info";

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
  }

  // Create an instance of the ProcessedCommand model and return it.
  return ProcessedCommand(
    customIconPath: customIcon.path,
    previousCFBundleIconFile: previousCFBundleIconFile,
    previousCFBundleIconName: previousCFBundleIconName,
  );
}

// The function to remove a custom icon for an app.
Future<void> unsetCustomIconForApp(App app) async {
  var shell = Shell(throwOnError: true);

  // Firstly, delete the custom icon file.
  File customIcon = File(app.customIconPath);
  await customIcon.delete();

  // Now, reset the app's icon to the previous default.
  final String appBundleInfoPath = "${app.path}/Contents/Info";

  try {
    await shell.run('''
      # Re-write the defaults.
      defaults write $appBundleInfoPath CFBundleIconFile "${app.previousCFBundleIconFile}"
      defaults write $appBundleInfoPath CFBundleIconName "${app.previousCFBundleIconName}"

      # Touch the app to update the icon.
      touch ${app.path}

      # Pretty much like setting the custom icon, we need to force-sign the app.
      codesign --force --deep --sign - ${app.path}
      ''');
  } catch (e) {
    debugPrint(e.toString());
  }
}
