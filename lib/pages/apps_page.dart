import 'dart:io';

import 'package:alter/utils/launch_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import 'package:alter/core/app_core.dart';
import 'package:alter/utils/file_picker.dart';
import 'package:alter/providers/app_database_provider.dart';

class AppsPage extends ConsumerStatefulWidget {
  const AppsPage({super.key});

  @override
  ConsumerState<AppsPage> createState() => _AppsPageState();
}

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
            icon: MacosIcon(
              CupertinoIcons.add_circled,
            ),
            label: 'Add',
            showLabel: true,
            onPressed: () async => await initiateAppAddingSequence(context),
          ),
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.refresh_bold,
            ),
            label: 'Refresh',
            showLabel: true,
            onPressed: () {},
          ),
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.trash,
            ),
            label: 'Reset All',
            showLabel: true,
            onPressed: () {
              ref.read(appDatabaseNotifierProvider.notifier).deleteAllApps();
            },
          ),
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.clear_circled,
            ),
            label: 'Kill Process',
            showLabel: true,
            onPressed: () {
              exit(0);
            },
          ),
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.globe,
            ),
            label: 'Get Icons',
            showLabel: true,
            onPressed: () async => await launchGetIconsPageOnWeb(context),
          ),
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.question_circle,
            ),
            label: 'Help',
            showLabel: true,
            onPressed: () async => await launchHelpPageOnWeb(context),
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            bool isDarkMode =
                MediaQuery.of(context).platformBrightness == Brightness.dark;

            Color secondaryColorDarkMode = Color.fromRGBO(28, 28, 28, 1.0);
            Color secondaryColorLightMode =
                Color.fromRGBO(228, 228, 228, 1.000);

            return SingleChildScrollView(
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
                                                .withOpacity(0.2),
                                            blurRadius: 10,
                                            spreadRadius: -3,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
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
                                      onPressed: () {},
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
                                  CupertinoColors.systemGrey.withOpacity(0.5),
                            )
                          ],
                        );
                      },
                    ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
