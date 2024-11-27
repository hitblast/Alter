// Third-party imports.
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:process_run/shell.dart';

// Local imports.
import 'package:alter/models/app.dart';
import 'package:alter/models/processed_command.dart';

// This function sets a custom icon for an app.
Future<ProcessedCommand> setCustomIconForApp(
  String appPath,
  String userCustomIconPath,
) async {
  // Get the custom icon file properly and copy it to the app's Resources folder.
  final File userCustomIcon = File(userCustomIconPath);
  final String userCustomIconName = userCustomIconPath.split('/').last;

  final File customIcon = await userCustomIcon
      .copy('$appPath/Contents/Resources/$userCustomIconName');

  // Setup shell environment for communication with commands.
  // Also get the path to the app's Info.plist file.
  var shell = Shell(throwOnError: true);
  final String appBundleInfoPath = "$appPath/Contents/Info";

  // Store these two for backup.
  late String previousCFBundleIconName;
  late String previousCFBundleIconFile;

  // Some apps do not have the CFBundleIconName key in their Info.plist file.
  // In that case, ignore read-writing it for that particular app only.
  try {
    previousCFBundleIconName =
        (await shell.run('defaults read "$appBundleInfoPath" CFBundleIconName'))
            .single
            .outText;
    await shell.run(
        'defaults write "$appBundleInfoPath" CFBundleIconName $userCustomIconName');
  } catch (e) {
    previousCFBundleIconName = '';
  }

  // Finally, set the required CFBundleIconFile key in the Info.plist file.
  // Also, touch and sign the app so that it can be used normally on macOS.
  try {
    previousCFBundleIconFile =
        (await shell.run('defaults read "$appBundleInfoPath" CFBundleIconFile'))
            .single
            .outText;

    await shell.run('''
      defaults write "$appBundleInfoPath" CFBundleIconFile "$userCustomIconName"

      touch "$appPath"

      codesign --force --deep --sign - "$appPath"
      ''');
  } catch (e) {
    debugPrint(e.toString());
  }

  // Return the processed command for further use by the database and providers.
  return ProcessedCommand(
    customIconPath: customIcon.path,
    previousCFBundleIconFile: previousCFBundleIconFile,
    previousCFBundleIconName: previousCFBundleIconName,
  );
}

// This function works directly in reverse to the previous one.
// It unsets the custom icon for an app.
Future<void> unsetCustomIconForApp(
  App app,
) async {
  // Setup shell environment for communication with commands.
  var shell = Shell(throwOnError: true);

  // Delete the custom icon file from the app's Resources folder.
  File customIcon = File(app.customIconPath);
  await customIcon.delete();

  // Get the path to the app's Info.plist file.
  final String appBundleInfoPath = "${app.path}/Contents/Info";

  // Restore the previous CFBundleIconName key in the Info.plist file.
  // Of course, this will be ignored if the previous key was empty / non-existent.
  if (app.previousCFBundleIconName.isNotEmpty) {
    await shell.run(
        'defaults write "$appBundleInfoPath" CFBundleIconName "${app.previousCFBundleIconName}"');
  }

  // Finally, restore the previous CFBundleIconFile key in the Info.plist file.
  try {
    await shell.run('''
      defaults write "$appBundleInfoPath" CFBundleIconFile "${app.previousCFBundleIconFile}"

      touch "${app.path}"

      codesign --force --deep --sign - "${app.path}"
      ''');
  } catch (e) {
    debugPrint(e.toString());
  }
}
