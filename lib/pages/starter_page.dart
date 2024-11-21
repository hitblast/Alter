// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/pages/iconchoosersheet_page.dart';
import 'package:alter/utils/dialogs.dart';
import 'package:alter/utils/file_picker.dart';

// The starter page widget.
// This is the first page that the user sees if the have no apps added to the database yet.
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      children: [
        ContentArea(
          builder: (BuildContext context, scrollController) {
            return GestureDetector(
              onTap: () async {
                debugPrint('Starter page tapped.');
                var file = await pickApplication();

                if (file == null) {
                  return;
                }

                // If the file is an application, continue with the process.
                else if (file.path.endsWith('.app')) {
                  // Currently dismissing system apps because it requires the implementation of
                  // symlinks inside the app. This is a security feature of macOS.
                  final bool isSystemApp =
                      await ifAppIsSystemApplication(file.path);

                  if (isSystemApp == true) {
                    if (!context.mounted) return;
                    showAlertDialog(context, 'System application!',
                        'Alter cannot alter system applications at this moment.');
                  }

                  // If not a system app, continue with the process.
                  else {
                    if (!context.mounted) return;

                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) =>
                            IconChooserSheetPage(appFile: file),
                      ),
                    );
                  }
                } else {
                  // If the app type is invalid, show this warning:
                  if (!context.mounted) return;
                  showAlertDialog(context, 'Invalid file type!',
                      'Please select a proper application file.');
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/alter_empty_page_front.png'),
                        width: 250,
                        height: 250,
                      ),
                      Text(
                        'Left-click to start customizing.',
                        style: TextStyle(
                          fontSize: 25,
                          color: CupertinoColors.systemGrey,
                          letterSpacing: -2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
