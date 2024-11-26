// Third-party imports.
import 'dart:io';

import 'package:alter/utils/app_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/pages/iconchoosersheet_page.dart';
import 'package:alter/utils/dialogs.dart';
import 'package:alter/utils/file_picker.dart';

// The function to initiate the app adding sequence.
Future<void> initiateAppAddingSequence(BuildContext context) async {
  var file = await pickApplication();

  if (file == null) {
    return;
  }

  // If the path already exists in the database.
  else if (await appExistsByPath(file.path)) {
    if (!context.mounted) return;
    showAlertDialog(
        context, 'App already exists!', 'Try adding a different application.');
  }

  // If the file is an application, continue with the process.
  else if (file.path.endsWith('.app') && await Directory(file.path).exists()) {
    // TODO: Currently dismissing system apps because it requires the implementation of
    // symlinks inside the app. This is a security feature of macOS.
    final bool isSystemApp = await ifAppIsSystemApplication(file.path);

    if (isSystemApp == true) {
      if (!context.mounted) return;
      showAlertDialog(context, 'System application!',
          'Alter cannot alter system applications at this moment.');
    }

    // If not a system app, continue with the process.
    else {
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
  } else {
    // If the app type is invalid, show a warning.
    if (!context.mounted) return;
    showAlertDialog(context, 'Invalid file type!',
        'Please select a proper application file.');
  }
}
