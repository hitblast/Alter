// Third-party imports.
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/app_database.dart';
import 'package:alter/pages/iconchoosersheet_page.dart';
import 'package:alter/utils/dialogs.dart';
import 'package:alter/utils/file_picker.dart';

// The function to initiate the app adding sequence.
Future<void> initiateAppAddingSequence(BuildContext context) async {
  var file = await pickApplication();

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
      !(await Directory(file.path).exists())) {
    if (!context.mounted) return;
    showAlertDialog(context, 'Invalid file type!',
        'Please select a proper application file.');
  }

  // If the app is a system app.
  else if (await ifAppIsSystemApplication(file.path)) {
    if (!context.mounted) return;
    showAlertDialog(context, 'System application!',
        'Alter cannot alter system applications.');
  }

  // If all of the checks above, actually pass. Then, route to IconChooserSheetPage.
  else {
    // TODO: Currently dismissing system apps because it requires the implementation of
    // symlinks inside the app. This is a security feature of macOS.

    if (!context.mounted) return;

    debugPrint("Chosen app: ${file.path}");
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
