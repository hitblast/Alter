// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

// The help sheet view for letting the users know about certain aspects of the app.
class HelpSheetPage extends StatelessWidget {
  const HelpSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: MacosSheet(
        insetAnimationDuration: const Duration(milliseconds: 500),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MacosIcon(
                        CupertinoIcons.info,
                        color: CupertinoColors.systemGrey,
                        size: 30,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'How to use?',
                        style: TextStyle(
                          fontSize: 21,
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: brightness == Brightness.dark
                          ? CupertinoColors.darkBackgroundGray
                          : CupertinoColors.systemGrey5,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Only the .icns file format is supported for icons as of now.',
                      style: TextStyle(
                        fontSize: 14,
                        color: brightness == Brightness.dark
                            ? CupertinoColors.destructiveRed
                            : CupertinoColors.systemGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Left-click on the blank starter screen / the "Add" button at the top of the apps page to pop-up the prompt for app selection. You must select a valid macOS application. \n\nThen, tap on the icon grid displayed on the icon selection page to select an icon. Finally, click on "Apply Changes" and wait for Alter to modify the existing app icon. This should only take a few seconds.',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  PushButton(
                    controlSize: ControlSize.large,
                    mouseCursor: SystemMouseCursors.click,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Gotcha!',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
