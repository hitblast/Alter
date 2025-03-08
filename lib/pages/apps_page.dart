// First-party imports.
import 'dart:io';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/core_sequences.dart';
import 'package:alter/utils/funcs.dart';
import 'package:alter/utils/links.dart';
import 'package:alter/pages/iconchooser_sheet_page.dart';
import 'package:alter/pages/settings_sheet_page.dart';
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
            icon: const MacosIcon(
              CupertinoIcons.add_circled,
            ),
            label: 'Add',
            tooltipMessage: 'Set an app\'s icon',
            showLabel: false,
            onPressed: () async => await initiateAppAddingSequence(context),
          ),
          ToolBarIconButton(
            icon: const MacosIcon(
              CupertinoIcons.refresh_bold,
            ),
            label: 'Refresh',
            tooltipMessage: 'Refresh user interface',
            showLabel: false,
            onPressed: () => ref.invalidate(appDatabaseNotifierProvider),
          ),
          ToolBarIconButton(
            icon: const MacosIcon(
              CupertinoIcons.trash,
            ),
            label: 'Reset All',
            tooltipMessage: 'Reset all changed icons',
            showLabel: false,
            onPressed: () =>
                ref.read(appDatabaseNotifierProvider.notifier).deleteAllApps(),
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
            icon: const MacosIcon(
              CupertinoIcons.paintbrush_fill,
            ),
            label: 'Get Icons',
            tooltipMessage: 'Browse for new app icons',
            showLabel: false,
            onPressed: () async =>
                await launchOnWeb(context, 'https://macosicons.com/'),
          ),
          ToolBarIconButton(
            icon: const MacosIcon(
              CupertinoIcons.settings,
            ),
            label: 'Settings',
            tooltipMessage: 'Show settings menu',
            showLabel: false,
            onPressed: () => showMacosSheet(
              context: context,
              builder: (context) {
                return SettingsSheetPage();
              },
            ),
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            bool isDarkMode =
                MediaQuery.of(context).platformBrightness == Brightness.dark;

            Color secondaryColorDarkMode = Color.fromRGBO(28, 28, 28, 0.5);
            Color secondaryColorLightMode =
                Color.fromRGBO(228, 228, 228, 1.000);

            return FadingEdgeScrollView.fromSingleChildScrollView(
              gradientFractionOnEnd: 0.3,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    for (var i = 0; i < apps.value!.length; i++)
                      Builder(
                        builder: (context) {
                          var app = apps.value![i];

                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode
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
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: CupertinoColors.black
                                                  .withValues(alpha: 0.2),
                                              blurRadius: 10,
                                              spreadRadius: -3,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () => openFileInPreview(
                                              app.customIconPath),
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
                                        getAppNameFromPath(app.path),
                                        style: TextStyle(
                                          fontSize: 15,
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
                                        child: Text('Update Icon'),
                                      ),
                                      const SizedBox(width: 10),
                                      PushButton(
                                        onPressed: () {
                                          ref
                                              .read(appDatabaseNotifierProvider
                                                  .notifier)
                                              .deleteApp(app.id);
                                        },
                                        controlSize: ControlSize.regular,
                                        secondary: true,
                                        child: Text('Remove'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color:
                                    CupertinoColors.inactiveGray.withAlpha(70),
                              )
                            ],
                          );
                        },
                      ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
