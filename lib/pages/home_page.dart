import 'package:alter/platform_menus.dart';
import 'package:alter/utils/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
