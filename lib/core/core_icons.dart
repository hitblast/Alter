// First-party imports.
import 'dart:io';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:process_run/shell.dart';

// Local imports.
import 'package:alter/models/app_model.dart';
import 'package:alter/models/commandresult_model.dart';

/// Set a custom icon for an app given its path.
/// Returns an optional CommandResult containing important, reusable data for the application.
/// If [iconToDelete] is passed, it will instead run in update mode.
Future<CommandResult?> setCustomIconForApp(
  String appPath,
  String userCustomIconPath, {
  String? iconToDelete,
}) async {
  // Get the original custom icon file name.
  // Then, modify the file name by adding _alterModify before the extension.
  final String originalFileName = userCustomIconPath.split('/').last;
  final int originalFileNameDotIndex = originalFileName.lastIndexOf('.');
  final String customIconFileName = originalFileNameDotIndex != -1
      ? "${originalFileName.substring(0, originalFileNameDotIndex)}_alterModify${originalFileName.substring(originalFileNameDotIndex)}"
      : "${originalFileName}_alterModify";

  // Setup shell environment for communication with commands.
  final shell = Shell(throwOnError: true);

  // Define path to Info.plist file of application.
  final String appBundleInfoPath = "$appPath/Contents/Info";

  // If iconToDelete is provided, delete the previous custom icon file if it exists.
  if (iconToDelete != null) {
    final File previousCustomIconFile =
        File("$appPath/Contents/Resources/$iconToDelete");
    if (await previousCustomIconFile.exists()) {
      await previousCustomIconFile.delete();
    }
  }

  // Copy the custom icon file to the app's Resources folder.
  final String customIconPath =
      "$appPath/Contents/Resources/$customIconFileName";
  await shell.run('''
    cp "$userCustomIconPath" "$customIconPath"
    chmod 644 "$appPath/Contents/Resources/$customIconFileName"
    ''');

  // Store these two for backup.
  late String previousCFBundleIconName;
  late String previousCFBundleIconFile;

  // Some apps do not have the CFBundleIconName key in their Info.plist file.
  // In that case, ignore read-writing it for that particular app only.
  String? tempCFBundleIconName;
  try {
    final readResult =
        await shell.run('defaults read "$appBundleInfoPath" CFBundleIconName');
    tempCFBundleIconName = readResult.single.outText;
  } catch (e) {
    tempCFBundleIconName = null;
  }
  if (tempCFBundleIconName != null) {
    previousCFBundleIconName = tempCFBundleIconName;
    await shell.run(
        'defaults write "$appBundleInfoPath" CFBundleIconName $customIconFileName');
  } else {
    previousCFBundleIconName = '';
  }

  // Set the required CFBundleIconFile key in the Info.plist file.
  // Also, touch and sign the app so that it can be used normally on macOS.
  try {
    previousCFBundleIconFile =
        (await shell.run('defaults read "$appBundleInfoPath" CFBundleIconFile'))
            .single
            .outText;

    await shell.run('''
        defaults write "$appBundleInfoPath" CFBundleIconFile "$customIconFileName"

        touch "$appPath"

        codesign --force --deep --sign - "$appPath"
        ''');
  } catch (e) {
    return null;
  }

  // Return the processed data for further use by the database and providers.
  return CommandResult(
    customIconPath: customIconPath,
    newCFBundleIconName:
        previousCFBundleIconName == '' ? '' : customIconFileName,
    newCFBundleIconFile: customIconFileName,
    previousCFBundleIconFile: previousCFBundleIconFile,
    previousCFBundleIconName: previousCFBundleIconName,
  );
}

/// Unset an App object's custom icon if one was previously applied on it.
/// This reverses the effects put in place by setCustomIconForApp().
Future<void> unsetCustomIconForApp(App app) async {
  final shell = Shell(throwOnError: true);

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
