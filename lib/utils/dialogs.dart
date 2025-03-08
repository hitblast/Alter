// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

/// This function shows macOS-native alert dialogs as needed by the application.
void showAlertDialog(
  BuildContext context,
  String title,
  String message,
) {
  showMacosAlertDialog(
    context: context,
    builder: (_) => MacosAlertDialog(
      appIcon: Image.asset('assets/images/alter_warning.png'),
      title: Text(title),
      message: Text(message),
      primaryButton: PushButton(
        controlSize: ControlSize.large,
        child: const Text('OK'),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
  );
}

/// This function shows macOS-native confirmation dialogs as needed by the application.
Future<bool> showConfirmationDialog(
  BuildContext context,
  String title,
  String message, {
  String yesLabel = 'Proceed',
  String noLabel = 'Cancel',
}) async {
  final result = await showMacosAlertDialog<bool>(
    context: context,
    builder: (_) => MacosAlertDialog(
      appIcon: Image.asset('assets/images/alter_warning.png'),
      title: Text(title),
      message: Text(message),
      horizontalActions: false,
      primaryButton: PushButton(
        controlSize: ControlSize.large,
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(yesLabel),
      ),
      secondaryButton: PushButton(
        controlSize: ControlSize.large,
        secondary: true,
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(noLabel),
      ),
    ),
  );
  return result ?? false;
}
