// First-party imports.
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class SettingsSheetPage extends StatelessWidget {
  const SettingsSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: MacosSheet(
        insetAnimationDuration: const Duration(milliseconds: 300),
        insetPadding: const EdgeInsets.only(
          top: 50,
          left: 60,
          right: 60,
          bottom: 50,
        ),
        insetAnimationCurve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
