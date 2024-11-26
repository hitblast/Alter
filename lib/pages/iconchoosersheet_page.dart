// Third-party imports.
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/providers/app_database_provider.dart';
import 'package:alter/utils/file_picker.dart';

// The macOS sheet view for choosing the icon when the user prompts.
class IconChooserSheetPage extends ConsumerStatefulWidget {
  const IconChooserSheetPage({super.key, required this.appFile});

  final XFile appFile;

  @override
  ConsumerState<IconChooserSheetPage> createState() =>
      _IconChooserSheetPageState();
}

// The state for the IconChooserSheetPage.
class _IconChooserSheetPageState extends ConsumerState<IconChooserSheetPage> {
  XFile? currentPickedIcon;
  var enableAnimatedBoxShadowOnIconSelect = false;

  @override
  Widget build(BuildContext context) {
    final appName = widget.appFile.name.replaceAll('.app', '');
    final brightness = MediaQuery.of(context).platformBrightness;

    return MacosSheet(
      insetAnimationDuration: Duration(milliseconds: 500),
      insetPadding: EdgeInsets.only(
        top: 50,
        left: 60,
        right: 60,
        bottom: 50,
      ),
      insetAnimationCurve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose icon for $appName',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      color: CupertinoColors.systemGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      final XFile? file = await pickIcon();

                      if (file != null) {
                        setState(() {
                          currentPickedIcon = file;
                          enableAnimatedBoxShadowOnIconSelect = true;
                        });
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: 0.4,
                            child: Image(
                              image: AssetImage('assets/alter_icon_frame.png'),
                              width: 155,
                              height: 155,
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(seconds: 2),
                            curve: Curves.fastOutSlowIn,
                            decoration: BoxDecoration(
                              boxShadow: enableAnimatedBoxShadowOnIconSelect
                                  ? [
                                      BoxShadow(
                                        color: CupertinoColors.activeGreen
                                            .withOpacity(0.3),
                                        offset: Offset(0, 5),
                                        blurRadius: 50,
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: CupertinoColors.systemGrey
                                            .withOpacity(0.3),
                                        offset: Offset(0, 5),
                                        blurRadius: 100,
                                      )
                                    ],
                            ),
                            child: currentPickedIcon != null
                                ? Image(
                                    image: FileImage(
                                        File(currentPickedIcon!.path)),
                                    width: 145,
                                    height: 145,
                                  )
                                : Image(
                                    image: AssetImage(
                                      brightness == Brightness.dark
                                          ? 'assets/alter_empty_dark.png'
                                          : 'assets/alter_empty_light.png',
                                    ),
                                    width: 145,
                                    height: 145,
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    currentPickedIcon != null
                        ? 'You can modify by left-clicking again!'
                        : 'Left-click above to choose a new icon.',
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PushButton(
                        controlSize: ControlSize.large,
                        secondary: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: 10),
                      Text('or'),
                      SizedBox(width: 10),
                      PushButton(
                        controlSize: ControlSize.large,
                        secondary: currentPickedIcon != null ? false : true,
                        onPressed: () {
                          if (currentPickedIcon == null) {
                            return;
                          }
                          ref.read(appDatabaseNotifierProvider.notifier).addApp(
                              widget.appFile.path, currentPickedIcon!.path);
                          Navigator.of(context).pop();
                        },
                        child: Text('Apply Changes'),
                      )
                    ],
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
