// First-party imports.
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/core_blacklist.dart';
import 'package:alter/core/core_database.dart';
import 'package:alter/pages/iconchooser_sheet_page.dart';
import 'package:alter/utils/dialogs.dart';
import 'package:alter/utils/funcs.dart';

/// The function to initiate the sequence for killing the application.
Future<void> initiateKillSequence(BuildContext context) async {
  final shouldKill = await showConfirmationDialog(
    context,
    'Kill Alter?',
    'Alter will stop running all background processes and quit promptly.',
    noLabel: 'Continue using app',
  );
  if (shouldKill) {
    exit(0);
  }
}

/// The function to initiate the app adding sequence.
Future<void> initiateAppAddingSequence(BuildContext context) async {
  var file = await openFile(initialDirectory: '/Applications');

  // Simply return if the user hasn't selected any file to modify.
  if (file == null) {
    return;
  }

  // If the path already exists in the database.
  else if (await appExistsByPath(file.path)) {
    if (!context.mounted) return;
    showAlertDialog(
        context, 'App already exists!', 'Try adding a different application.');
  }

  // If the app has authentic macOS app properties (e.g. is a folder and ends with the .app extension).
  else if (!file.path.endsWith('.app') &&
      !await Directory(file.path).exists() &&
      await Directory('${file.path}/Resources').exists() &&
      await Directory('${file.path}/Contents').exists() &&
      await File('${file.path}/Contents/Info.plist').exists()) {
    if (!context.mounted) return;
    showAlertDialog(context, 'Invalid file type!',
        'Please select a proper application file.');
  }

  // If the app is a system app.
  else if (await ifAppIsSystemApplication(file.path)) {
    if (!context.mounted) return;
    showAlertDialog(context, 'System application!',
        'Alter cannot modify system applications for now.');
  }

  // If the app has a _MASReceipt folder (indicating it as an App store application).
  else if (await Directory('${file.path}/Contents/_MASReceipt').exists()) {
    if (!context.mounted) return;
    showAlertDialog(context, 'App Store app!',
        'Alter cannot modify App Store applications for now.');
  }

  // If all of the checks above pass.
  else {
    // Check if the selected app is blacklisted.
    final appName = getAppNameFromPath(file.path);

    if (blacklistedApps.contains(appName) && context.mounted) {
      final proceed = await showConfirmationDialog(
        context,
        'Blacklist warning!',
        "$appName may not work well with modifications.",
        yesLabel: 'Modify anyway',
        noLabel: 'Cancel',
      );
      if (!proceed) {
        return;
      }
    }

    debugPrint('Chosen app: ${file.path}');

    if (!context.mounted) return;
    showMacosSheet(
      context: context,
      builder: (context) {
        return IconChooserSheetPage(
          appFile: file,
        );
      },
    );
  }
}
