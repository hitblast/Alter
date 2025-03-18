// First-party imports.
import 'dart:io';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:process_run/shell.dart';
import 'package:path/path.dart' as path;

// Local imports.
import 'package:alter/models/app_model.dart';
import 'package:alter/models/commandresult_model.dart';
import 'package:alter/core/core_sips.dart';
import 'package:alter/core/core_icon_storage.dart';

/// Resets system-granted permissions for the app - given its absolute path.
/// This is essential for execution when the code signature for a particular app has been changed.
Future<String?> _resetPermissions(String appPath) async {
  final shell = Shell();

  try {
    final appBundleId =
        (await shell.run("""
            osascript -e 'id of app "$appPath"'
        """)).single.outText;

    // Call tccutil to reset.
    await shell.run('tccutil reset All $appBundleId');
    debugPrint('Reset permissions for bundle ID: $appBundleId');

    return appBundleId;
  } catch (_) {
    return null;
  }
}

/// Set a custom icon for an app given its path.
/// Returns an optional CommandResult containing important, reusable data for the application.
/// If [iconToDelete] is passed, it will instead run in update mode.
Future<CommandResult?> setCustomIconForApp(
  String appPath,
  String userCustomIconPath, {
  String? iconToDelete,
}) async {
  // Determine file info and whether the icon is a PNG.
  final String originalFileName = path.basename(userCustomIconPath);
  final int dotIndex = originalFileName.lastIndexOf('.');
  final bool isPng = originalFileName.endsWith('.png');
  final String customIconFileName =
      isPng
          ? "${originalFileName.substring(0, dotIndex)}_alterModify.icns"
          : (dotIndex != -1
              ? "${originalFileName.substring(0, dotIndex)}_alterModify${originalFileName.substring(dotIndex)}"
              : "${originalFileName}_alterModify");

  // If a PNG file is provided, convert it to ICNS.
  String iconPathToUse = userCustomIconPath;
  File? convertedIconFile;
  if (isPng) {
    convertedIconFile = await convertToIcns(userCustomIconPath);
    iconPathToUse = convertedIconFile.path;
  }

  // Initialize shell and define paths.
  final shell = Shell();
  final String appBundleInfoPath = path.join(appPath, 'Contents', 'Info');
  final String customIconPath = path.join(
    appPath,
    'Contents',
    'Resources',
    customIconFileName,
  );

  if (iconToDelete != null) {
    final File previousIconFile = File(
      path.join(appPath, 'Contents', 'Resources', iconToDelete),
    );
    if (await previousIconFile.exists()) {
      await previousIconFile.delete();
    }
  }

  // Copy the (possibly converted) icon to the app's Resources folder and set permissions.
  await shell.run('''
    cp "$iconPathToUse" "$customIconPath"
    chmod 644 "$customIconPath"
    ''');

  // If a PNG was converted, delete the converted icon after copying.
  if (isPng && convertedIconFile != null && await convertedIconFile.exists()) {
    await convertedIconFile.delete();
  }

  // Backup current CFBundleIconName if it exists.
  // Some applications can be modified without writing this property.
  late String previousCFBundleIconName;

  String? currentIconName;
  try {
    currentIconName =
        (await shell.run(
          'defaults read "$appBundleInfoPath" CFBundleIconName',
        )).single.outText;
  } catch (e) {
    currentIconName = null;
  }

  if (currentIconName != null) {
    previousCFBundleIconName = currentIconName;
    await shell.run(
      'defaults write "$appBundleInfoPath" CFBundleIconName "$customIconFileName"',
    );
  } else {
    previousCFBundleIconName = '';
  }

  // Backup and update CFBundleIconFile key, then touch and codesign the app.
  late String previousCFBundleIconFile;
  try {
    previousCFBundleIconFile =
        (await shell.run(
          'defaults read "$appBundleInfoPath" CFBundleIconFile',
        )).single.outText;

    await shell.run('''
        defaults write "$appBundleInfoPath" CFBundleIconFile "$customIconFileName"
        touch "$appPath"
        codesign --force --deep --sign - "$appPath"
        ''');
  } catch (e) {
    return null;
  }

  // Reset permissions for the app here.
  final appBundleId = await _resetPermissions(appPath);

  // Store the custom icon for backup and reapplying.
  await storeCustomIconInStorage(customIconPath, appPath);

  // Return the command result with the necessary data.
  return CommandResult(
    customIconPath: customIconPath,
    appBundleId: appBundleId ?? '',
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
  final shell = Shell();

  // Delete the custom icon file.
  final File customIcon = File(app.customIconPath);
  await customIcon.delete();

  // Define the path to the app's Info.plist.
  final String appBundleInfoPath = path.join(app.path, 'Contents', 'Info');

  // Restore CFBundleIconName if it was modified.
  if (app.previousCFBundleIconName.isNotEmpty) {
    await shell.run(
      'defaults write "$appBundleInfoPath" CFBundleIconName "${app.previousCFBundleIconName}"',
    );
  }

  // Delete the backup icon file.
  await deleteStoredIconForAppPath(app.path);

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

  // Reset permissions if needed.
  if (app.appBundleId != '') {
    await _resetPermissions(app.path);
  }
}

/// Returns a boolean value for an App object if its custom icon needs to be reapplied.
Future<bool> shouldReapplyIcon(App app) async {
  final shell = Shell();

  final String appBundleInfoPath = path.join(app.path, 'Contents', 'Info');
  late String readCFBundleIconName;
  late String readCFBundleIconFile;

  // Optional check triggered for the current value of CFBundleIconName.
  if (app.previousCFBundleIconName != '') {
    readCFBundleIconName =
        (await shell.run(
          'defaults read "$appBundleInfoPath" CFBundleIconName',
        )).single.outText;

    if (readCFBundleIconName != app.newCFBundleIconName) {
      return true;
    }
  }

  // Either way, CFBundleIconFile gets checked for sure.
  readCFBundleIconFile =
      (await shell.run(
        'defaults read "$appBundleInfoPath" CFBundleIconFile',
      )).single.outText;

  if (readCFBundleIconFile != app.newCFBundleIconFile) {
    return true;
  }

  // Also blow the alarm if the icon is missing.
  if (!await File(app.customIconPath).exists()) {
    return true;
  }

  return false;
}
