// First-party imports.
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Third-party imports.
import 'package:path/path.dart' as path;
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/utils/funcs.dart';
import 'package:alter/providers/app_database_provider.dart';

/// The macOS sheet view for choosing the icon when the user prompts.
class IconChooserSheetPage extends ConsumerStatefulWidget {
  const IconChooserSheetPage({
    super.key,
    required this.appFile,
    this.preexistingAppId,
  });

  final XFile appFile;
  final int? preexistingAppId;

  @override
  ConsumerState<IconChooserSheetPage> createState() =>
      _IconChooserSheetPageState();
}

/// The state for the IconChooserSheetPage.
class _IconChooserSheetPageState extends ConsumerState<IconChooserSheetPage> {
  XFile? currentPickedIcon;
  Color? dominantColor;

  // Boolean value indicating if the user has picked an icon.
  bool get hasPickedIcon => currentPickedIcon != null;
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appName = path.basenameWithoutExtension(widget.appFile.path);
    final brightness = MediaQuery.of(context).platformBrightness;

    return MacosSheet(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (widget.preexistingAppId != null)
                        ? 'Modify icon for $appName'
                        : 'Select icon for $appName',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      color: CupertinoColors.systemGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      final XFile? file = await pickIcon();

                      if (file != null) {
                        setState(() {
                          currentPickedIcon = file;
                        });
                        final ColorScheme scheme =
                            await ColorScheme.fromImageProvider(
                              provider: FileImage(File(file.path)),
                              brightness: brightness,
                            );
                        setState(() {
                          dominantColor = scheme.primary;
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
                            child: Image.asset(
                              'assets/images/alter_icon_frame.png',
                              width: 155,
                              height: 155,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              boxShadow:
                                  hasPickedIcon
                                      ? [
                                        BoxShadow(
                                          color: dominantColor!.withAlpha(80),
                                          blurRadius: 50,
                                        ),
                                      ]
                                      : [
                                        BoxShadow(
                                          color: CupertinoColors.systemGrey
                                              .withAlpha(50),
                                          blurRadius: 50,
                                        ),
                                      ],
                            ),
                            child:
                                hasPickedIcon
                                    ? Image(
                                      image: FileImage(
                                        File(currentPickedIcon!.path),
                                      ),
                                      width: 145,
                                      height: 145,
                                    )
                                    : brightness == Brightness.dark
                                    ? Image.asset(
                                      'assets/images/alter_empty_dark.png',
                                      width: 145,
                                      height: 145,
                                    )
                                    : Image.asset(
                                      'assets/images/alter_empty_light.png',
                                      width: 145,
                                      height: 145,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    hasPickedIcon
                        ? 'Modify again by left-clicking!'
                        : ' Drag or left-click to choose a new icon.',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PushButton(
                        controlSize: ControlSize.large,
                        secondary: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      const Text('or'),
                      const SizedBox(width: 10),
                      PushButton(
                        controlSize: ControlSize.large,
                        secondary: !hasPickedIcon,
                        onPressed:
                            hasPickedIcon
                                ? () async {
                                  if (!hasPickedIcon) {
                                    return;
                                  }

                                  if (widget.preexistingAppId == null) {
                                    ref
                                        .read(
                                          appDatabaseNotifierProvider.notifier,
                                        )
                                        .addApp(
                                          widget.appFile.path,
                                          currentPickedIcon!.path,
                                        );
                                  } else {
                                    ref
                                        .read(
                                          appDatabaseNotifierProvider.notifier,
                                        )
                                        .updateAppIcon(
                                          widget.preexistingAppId!,
                                          currentPickedIcon!.path,
                                        );
                                  }

                                  Navigator.of(context).pop();
                                }
                                : null,
                        child: Text('Apply Changes'),
                      ),
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
