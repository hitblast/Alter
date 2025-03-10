// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

/// The settings sheet page which can be used to directly modify the inner configuration of Alter.
class SettingsSheetPage extends StatelessWidget {
  const SettingsSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: const MacosSheet(
        insetAnimationDuration: Duration(milliseconds: 300),
        insetPadding: EdgeInsets.all(50),
        insetAnimationCurve: Curves.easeInOut,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MacosIcon(
                        CupertinoIcons.settings,
                        color: CupertinoColors.systemGrey,
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Configuration',
                        style: TextStyle(
                          fontSize: 20,
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'This page is still a work-in-progress.',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
