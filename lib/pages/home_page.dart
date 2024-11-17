import 'package:alter/platform_menus.dart';
import 'package:alter/utils/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

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

                  if (file != null) {
                    if (kDebugMode) {
                      print('File path: ${file.path}');
                    }
                  } else {
                    showMacosAlertDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (_) => MacosAlertDialog(
                          appIcon: const Image(
                              image: AssetImage(
                                  'assets/alter_empty_page_front.png')),
                          title: const Text('Not an application!'),
                          message: const Text(
                              'Please select an application with the .app extension.'),
                          primaryButton: PushButton(
                              controlSize: ControlSize.large,
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })),
                    );
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
