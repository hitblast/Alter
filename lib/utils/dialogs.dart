// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

void showAlertDialog(BuildContext context, String title, String message) {
  showMacosAlertDialog(
    context: context,
    builder: (_) => MacosAlertDialog(
        appIcon: const Image(image: AssetImage('assets/alter_warning.png')),
        title: Text(title),
        message: Text(message),
        primaryButton: PushButton(
            controlSize: ControlSize.large,
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            })),
  );
}
