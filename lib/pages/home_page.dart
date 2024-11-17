// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/platform_menus.dart';
import 'package:alter/utils/dialogs.dart';
import 'package:alter/utils/file_picker.dart';

// The home page of the application.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// The state of the home page.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: menuBarItems(),
      child: MacosScaffold(
        children: [
          ContentArea(
            builder: (context, scrollController) {
              // TODO: this is for empty pages, update later for filled-up pages with icons
              return GestureDetector(
                onTap: () async {
                  if (kDebugMode) {
                    print('Left-clicked on the empty page.');
                  }
                  var file = await pickApplication();

                  if (file == null) {
                    return;
                  } else if (file.path.endsWith('.app')) {
                    if (kDebugMode) {
                      print('File path: ${file.path}');
                    }

                    final bool? isSystemApp =
                        await ifAppIsSystemApplication(file.path);

                    if (isSystemApp == true) {
                      if (!context.mounted) return;
                      showAlertDialog(context, 'System application!',
                          'Alter cannot alter system applications at this moment.');
                    }
                  } else {
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
                          image:
                              AssetImage('assets/alter_empty_page_front.png'),
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
      ),
    );
  }
}
