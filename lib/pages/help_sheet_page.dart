// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

// The help sheet view for letting the users know about certain aspects of the app.
class HelpSheetPage extends StatelessWidget {
  const HelpSheetPage({super.key});

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
                children: [
                  const MacosIcon(CupertinoIcons.info_circle_fill, size: 30),
                  const SizedBox(height: 15),
                  const Text(
                    'How to use?',
                    style: TextStyle(
                      fontSize: 21,
                      color: CupertinoColors.systemGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Left-click the starter screen, or the "+" icon on the toolbar to start customizing an application\'s icon. You\'ll have to choose a valid macOS app, typically located inside the "Applications" folder.\n\nNow, choose a valid image to apply as the icon by clicking on the icon frame. Note that the image must either be in .icns or .png format. Finally, click on "Apply Changes" and wait a few seconds to complete the procedure.',
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
