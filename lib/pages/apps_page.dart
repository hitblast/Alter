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
            onPressed: () async {
              final shouldResetAll = await showConfirmationDialog(
                context,
                'Reset all apps?',
                'This will reset all changed icons and remove all customizations.',
              );
              if (shouldResetAll) {
                ref.read(appDatabaseNotifierProvider.notifier).deleteAllApps();
              }
            },
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

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CupertinoColors.systemGrey2.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    color:
                        isDarkMode
                            ? secondaryColorDarkMode
                            : secondaryColorLightMode,
                  ),
                  padding: const EdgeInsets.all(17),
                  child: MacosListTile(
                    leading: Row(
                      children: [
                        Text(
                          '${i + 1}.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
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
                            onTap: () async {
                              final fileHasOpened = await funcs
                                  .openFileInPreview(app.customIconPath);

                              if (!fileHasOpened && context.mounted) {
                                showAlertDialog(
                                  context,
                                  'Could not preview icon.',
                                  'There was an error opening the icon file.',
                                );
                              }
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Image.file(
                                File(app.customIconPath),
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        Text(
                          path.basenameWithoutExtension(app.path),
                          style: const TextStyle(fontSize: 15.5),
                        ),
                        const Spacer(),
                        MacosTooltip(
                          message: 'Edit custom icon',
                          child: MacosIconButton(
                            onPressed: () {
                              showMacosSheet(
                                context: context,
                                builder: (builder) {
                                  return IconChooserSheetPage(
                                    appFile: XFile(app.path),
                                    preexistingAppId: app.id,
                                  );
                                },
                              );
                            },
                            icon: const MacosIcon(
                              CupertinoIcons.pencil,
                              size: 20,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ),
                        MacosTooltip(
                          message: 'Remove app and unapply icon',
                          child: MacosIconButton(
                            onPressed: () async {
                              final shouldDeleteApp = await showConfirmationDialog(
                                context,
                                'Remove app?',
                                'This will reset all applied modifications and app permissions.',
                              );

                              if (shouldDeleteApp) {
                                ref
                                    .read(appDatabaseNotifierProvider.notifier)
                                    .deleteApp(app.id);
                              }
                            },
                            icon: const MacosIcon(
                              CupertinoIcons.trash_fill,
                              color: CupertinoColors.systemGrey,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Text(app.path, style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
