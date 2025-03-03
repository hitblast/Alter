// First-party imports.
import 'dart:io';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/core_database.dart';
import 'package:alter/pages/iconchooser_sheet_page.dart';
import 'package:alter/utils/dialog_util.dart';
import 'package:alter/utils/file_util.dart';

/// The function to initiate the sequence for killing the application.
Future<void> initiateKillSequence(BuildContext context) async {
  showMacosAlertDialog(
    context: context,
    builder: (_) => MacosAlertDialog(
      appIcon: Image.asset('assets/images/alter_warning.png'),
      horizontalActions: false,
      title: Text(
        'Kill Alter?',
        style: MacosTheme.of(context).typography.headline,
      ),
      message: Text(
        'This will permanently stop all background processes till you open the app again.',
        textAlign: TextAlign.center,
      ),
      primaryButton: PushButton(
        controlSize: ControlSize.large,
        child: Text('Proceed'),
        onPressed: () => exit(0),
      ),
      secondaryButton: PushButton(
        secondary: true,
        controlSize: ControlSize.large,
        child: Text('Keep it running'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
  );
}

/// The function to initiate the app adding sequence.
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
        'Alter cannot modify system applications for now.');
  }

  // If the app has a _MASReceipt folder (indicating it as an App store application).
  else if (await Directory('${file.path}/Contents/_MASReceipt').exists()) {
    if (!context.mounted) return;
    showAlertDialog(context, 'App Store app!',
        'Alter cannot modify App Store applications for now.');
  }

  // If all of the checks above, actually pass. Then, route to IconChooserSheetPage.
  else {
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
