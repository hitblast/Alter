// Third-party imports.
import 'dart:io';

import 'package:alter/utils/launch_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/app_core.dart';
import 'package:alter/utils/file_picker.dart';
import 'package:alter/providers/app_database_provider.dart';

// The apps page.
// This page is shown if the user has already populated Alter with apps to customize.
class AppsPage extends ConsumerStatefulWidget {
  const AppsPage({super.key});

  @override
  ConsumerState<AppsPage> createState() => _AppsPageState();
}

// The state for the AppsPage widget.
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
              // quit the app
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

            // Altering colors for the list items.
            Color primaryColorDarkMode = Color.fromRGBO(40, 40, 40, 1.0);
            Color secondaryColorDarkMode = Color.fromRGBO(28, 28, 28, 1.0);
            Color primaryColorLightMode = Color.fromRGBO(246, 246, 246, 1.000);
            Color secondaryColorLightMode =
                Color.fromRGBO(228, 228, 228, 1.000);

            var previousColor =
                isDarkMode ? primaryColorDarkMode : primaryColorLightMode;

            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 0; i < apps.value!.length; i++)
                    Builder(
                      builder: (context) {
                        var app = apps.value![i];

                        // Alter the colors between the list items.
                        if (isDarkMode) {
                          previousColor = previousColor == primaryColorDarkMode
                              ? secondaryColorDarkMode
                              : primaryColorDarkMode;
                        } else {
                          previousColor = previousColor == primaryColorLightMode
                              ? secondaryColorLightMode
                              : primaryColorLightMode;
                        }

                        return MouseRegion(
                          child: Container(
                            decoration: BoxDecoration(
                              color: previousColor,
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
                                    child: Image.file(
                                      File(app.customIconPath),
                                      width: 70,
                                      height: 70,
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
                        );
                      },
                    ),
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: isDarkMode
                        ? secondaryColorDarkMode
                        : secondaryColorLightMode,
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
