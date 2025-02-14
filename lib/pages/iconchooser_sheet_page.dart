// First-party imports.
import 'dart:io';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/gen/assets.gen.dart';
import 'package:alter/utils/file_util.dart';
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

  // Boolean value indicating if the user has picked an icon.
  bool get hasPickedIcon => currentPickedIcon != null;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final appName = widget.appFile.name.replaceAll('.app', '');
    final brightness = MediaQuery.of(context).platformBrightness;

    return MacosSheet(
      insetAnimationDuration: const Duration(milliseconds: 300),
      insetPadding: const EdgeInsets.all(50),
      insetAnimationCurve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: FadingEdgeScrollView.fromSingleChildScrollView(
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
                        }
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: 0.4,
                              child: Assets.images.alterIconFrame.image(
                                width: 155,
                                height: 155,
                              ),
                            ),
                            AnimatedContainer(
                              duration: Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn,
                              decoration: BoxDecoration(
                                boxShadow: hasPickedIcon
                                    ? [
                                        BoxShadow(
                                          color: CupertinoColors.activeGreen
                                              .withAlpha(77),
                                          offset: Offset(0, 5),
                                          blurRadius: 50,
                                        ),
                                      ]
                                    : [
                                        BoxShadow(
                                          color: CupertinoColors.systemGrey
                                              .withAlpha(50),
                                          offset: Offset(0, 5),
                                          blurRadius: 50,
                                        )
                                      ],
                              ),
                              child: hasPickedIcon
                                  ? Image(
                                      image: FileImage(
                                        File(currentPickedIcon!.path),
                                      ),
                                      width: 145,
                                      height: 145,
                                    )
                                  : brightness == Brightness.dark
                                      ? Assets.images.alterEmptyDark.image(
                                          width: 145,
                                          height: 145,
                                        )
                                      : Assets.images.alterEmptyLight.image(
                                          width: 145,
                                          height: 145,
                                        ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      hasPickedIcon
                          ? 'You can modify by left-clicking again!'
                          : 'Left-click above to choose a new icon.',
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
                          onPressed: hasPickedIcon
                              ? () async {
                                  if (!hasPickedIcon) {
                                    return;
                                  }

                                  if (widget.preexistingAppId == null) {
                                    ref
                                        .read(appDatabaseNotifierProvider
                                            .notifier)
                                        .addApp(widget.appFile.path,
                                            currentPickedIcon!.path);
                                  } else {
                                    ref
                                        .read(appDatabaseNotifierProvider
                                            .notifier)
                                        .updateAppIcon(
                                          widget.preexistingAppId!,
                                          currentPickedIcon!.path,
                                        );
                                  }

                                  Navigator.of(context).pop();
                                }
                              : null,
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
      ),
    );
  }
}
