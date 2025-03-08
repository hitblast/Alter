// First-party imports.
import 'dart:io';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:process_run/shell.dart';

// Local imports.
import 'package:alter/models/app_model.dart';
import 'package:alter/models/commandresult_model.dart';
import 'package:alter/core/core_sips.dart';

/// Set a custom icon for an app given its path.
/// Returns an optional CommandResult containing important, reusable data for the application.
/// If [iconToDelete] is passed, it will instead run in update mode.
Future<CommandResult?> setCustomIconForApp(
  String appPath,
  String userCustomIconPath, {
  String? iconToDelete,
}) async {
  // Determine file info and whether the icon is a PNG.
  final String originalFileName = userCustomIconPath.split('/').last;
  final int dotIndex = originalFileName.lastIndexOf('.');
  final bool isPng = userCustomIconPath.toLowerCase().endsWith('.png');
  final String customIconFileName = isPng
      ? "${originalFileName.substring(0, dotIndex)}_alterModify.icns"
      : (dotIndex != -1
          ? "${originalFileName.substring(0, dotIndex)}_alterModify${originalFileName.substring(dotIndex)}"
          : "${originalFileName}_alterModify");

  // If a PNG file is provided, convert it to ICNS.
  String iconPathToUse = userCustomIconPath;
  if (isPng) {
    final convertedIcon = await convertToIcns(userCustomIconPath);
    iconPathToUse = convertedIcon.path;
  }

  // Initialize shell and define paths.
  final shell = Shell(throwOnError: true);
  final String appBundleInfoPath = "$appPath/Contents/Info";
  final String customIconPath =
      "$appPath/Contents/Resources/$customIconFileName";

  // Delete previous custom icon if requested.
  if (iconToDelete != null) {
    final File previousIconFile =
        File("$appPath/Contents/Resources/$iconToDelete");
    if (await previousIconFile.exists()) {
      await previousIconFile.delete();
    }
  }

  // Copy the (possibly converted) icon to the app's Resources folder and set permissions.
  await shell.run('''
    cp "$iconPathToUse" "$customIconPath"
    chmod 644 "$appPath/Contents/Resources/$customIconFileName"
    ''');

  // Backup current CFBundleIconName and CFBundleIconFile.
  late String previousCFBundleIconName;
  late String previousCFBundleIconFile;

  String? currentIconName;
  try {
    final readResult =
        await shell.run('defaults read "$appBundleInfoPath" CFBundleIconName');
    currentIconName = readResult.single.outText;
  } catch (e) {
    currentIconName = null;
  }
  if (currentIconName != null) {
    previousCFBundleIconName = currentIconName;
    await shell.run(
        'defaults write "$appBundleInfoPath" CFBundleIconName $customIconFileName');
  } else {
    previousCFBundleIconName = '';
  }

  // Backup and update CFBundleIconFile key, then touch and codesign the app.
  try {
    final readResult =
        await shell.run('defaults read "$appBundleInfoPath" CFBundleIconFile');
    previousCFBundleIconFile = readResult.single.outText;
    await shell.run('''
        defaults write "$appBundleInfoPath" CFBundleIconFile "$customIconFileName"
        touch "$appPath"
        codesign --force --deep --sign - "$appPath"
        ''');
  } catch (e) {
    return null;
  }

  // Return the command result with the necessary data.
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
  // Delete the custom icon file.
  final File customIcon = File(app.customIconPath);
  await customIcon.delete();

  // Define the path to the app's Info.plist.
  final String appBundleInfoPath = "${app.path}/Contents/Info";

  // Restore CFBundleIconName if it was modified.
  if (app.previousCFBundleIconName.isNotEmpty) {
    await shell.run(
        'defaults write "$appBundleInfoPath" CFBundleIconName "${app.previousCFBundleIconName}"');
  }

  // Restore CFBundleIconFile, touch and codesign the app.
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
