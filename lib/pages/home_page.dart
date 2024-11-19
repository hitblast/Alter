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
        toolBar: const ToolBar(),
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
                    final bool isSystemApp =
                        await ifAppIsSystemApplication(file.path);
                    if (isSystemApp == true) {
                      if (!context.mounted) return;
                      showAlertDialog(context, 'System application!',
                          'Alter cannot alter system applications at this moment.');
                    } else {
                      if (!context.mounted) return;
                      showMacosSheet(
                          context: context,
                          builder: (_) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: MacosSheet(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Set icon for ${file.name.replaceAll('.app', '')}:',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: CupertinoColors.systemGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      PushButton(
                                        controlSize: ControlSize.regular,
                                        child: Text('Apply Changes'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
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
