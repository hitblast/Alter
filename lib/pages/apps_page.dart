// First-party imports.
import 'dart:io';
import 'package:alter/utils/dialogs.dart';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:path/path.dart' as path;
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/sequences.dart';
import 'package:alter/utils/funcs.dart' as funcs;
import 'package:alter/utils/links.dart';
import 'package:alter/pages/iconchooser_sheet_page.dart';
import 'package:alter/providers/app_database_provider.dart';

/// The apps page.
/// This page is shown if the user has already populated Alter with apps to customize.
class AppsPage extends ConsumerStatefulWidget {
  const AppsPage({super.key});

  @override
  ConsumerState<AppsPage> createState() => _AppsPageState();
}

/// The state for the AppsPage widget.
class _AppsPageState extends ConsumerState<AppsPage> {
  @override
  Widget build(BuildContext context) {
    var apps = ref.watch(appDatabaseNotifierProvider);

    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('Manage Apps'),
        enableBlur: true,
        actions: [
          ToolBarIconButton(
            icon: const MacosIcon(CupertinoIcons.add_circled),
            label: 'Add',
            tooltipMessage: 'Set an app\'s icon',
            showLabel: false,
            onPressed: () async => await initiateAppAddingSequence(context),
          ),
          ToolBarIconButton(
            icon: const MacosIcon(CupertinoIcons.trash),
            label: 'Reset All',
            tooltipMessage: 'Reset all changed icons',
            showLabel: false,
            onPressed:
                () =>
                    ref
                        .read(appDatabaseNotifierProvider.notifier)
                        .deleteAllApps(),
          ),
          ToolBarIconButton(
            icon: const MacosIcon(
              CupertinoIcons.xmark_shield_fill,
              color: CupertinoColors.destructiveRed,
            ),
            label: 'Restart services',
            tooltipMessage:
                'Restart essential system services (Finder, Dock, SystemUIServer)',
            showLabel: false,
            onPressed: () async {
              final shouldKill = await showConfirmationDialog(
                context,
                'Restart services?',
                'This action will restart Finder, Dock and SystemUIServer.',
              );

              if (shouldKill) {
                await funcs.killSystemServices();
              }
            },
          ),
          ToolBarIconButton(
            icon: const MacosIcon(
              CupertinoIcons.xmark_octagon,
              color: CupertinoColors.destructiveRed,
            ),
            label: 'Kill Process',
            tooltipMessage: 'Kill Alter and halt background processing',
            showLabel: false,
            onPressed: () => initiateKillSequence(context),
          ),
          ToolBarIconButton(
            icon: const MacosIcon(CupertinoIcons.paintbrush_fill),
            label: 'Get Icons',
            tooltipMessage: 'Browse for new app icons',
            showLabel: false,
            onPressed:
                () async =>
                    await launchOnWeb(context, 'https://macosicons.com/'),
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            bool isDarkMode =
                MediaQuery.of(context).platformBrightness == Brightness.dark;

            Color secondaryColorDarkMode = Color.fromRGBO(28, 28, 28, 0.5);
            Color secondaryColorLightMode = Color.fromRGBO(
              228,
              228,
              228,
              1.000,
            );

            return ListView.builder(
              controller: scrollController,
              itemCount: apps.value!.length + 1,
              itemBuilder: (context, i) {
                if (i == apps.value!.length) {
                  return const SizedBox(height: 80);
                }
                var app = apps.value![i];

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color:
                            isDarkMode
                                ? secondaryColorDarkMode
                                : secondaryColorLightMode,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          left: 25,
                          right: 25,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${i + 1}.',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.black.withValues(
                                      alpha: 0.2,
                                    ),
                                    blurRadius: 10,
                                    spreadRadius: -3,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap:
                                    () => funcs.openFileInPreview(
                                      app.customIconPath,
                                    ),
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Image.file(
                                    File(app.customIconPath),
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              path.basename(app.path),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            PushButton(
                              onPressed: () {
                                showMacosSheet(
                                  context: context,
                                  builder: (context) {
                                    return IconChooserSheetPage(
                                      appFile: XFile(app.path),
                                      preexistingAppId: app.id,
                                    );
                                  },
                                );
                              },
                              controlSize: ControlSize.regular,
                              secondary: true,
                              child: const Text('Update Icon'),
                            ),
                            const SizedBox(width: 10),
                            PushButton(
                              onPressed: () {
                                ref
                                    .read(appDatabaseNotifierProvider.notifier)
                                    .deleteApp(app.id);
                              },
                              controlSize: ControlSize.regular,
                              secondary: true,
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: CupertinoColors.inactiveGray.withAlpha(70),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
