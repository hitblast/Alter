// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/pages/iconchoosersheet_page.dart';
import 'package:alter/utils/dialogs.dart';
import 'package:alter/utils/file_picker.dart';

// The function to initiate the app adding sequence.
Future<void> initiateAppAddingSequence(BuildContext context) async {
  debugPrint('Starter page tapped.');
  var file = await pickApplication();

  if (file == null) {
    return;
  }

  // If the file is an application, continue with the process.
  else if (file.path.endsWith('.app')) {
    // Currently dismissing system apps because it requires the implementation of
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
    // If the app type is invalid, show this warning:
    if (!context.mounted) return;
    showAlertDialog(context, 'Invalid file type!',
        'Please select a proper application file.');
  }
}
