// Third-party imports.
import 'dart:io';

import 'package:alter/utils/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/providers/app_database_provider.dart';
import 'package:alter/utils/app_adding_seq.dart';

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
              CupertinoIcons.globe,
            ),
            label: 'Get Icons',
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
              CupertinoIcons.question_circle,
            ),
            label: 'Help',
            showLabel: true,
            onPressed: () =>
                debugPrint('Apps page: Toolbar help button clicked!'),
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            bool isDarkMode =
                MediaQuery.of(context).platformBrightness == Brightness.dark;

            // Altering colors for the list items.
            Color primaryColorDarkMode = CupertinoColors.black.withOpacity(0.1);
            Color secondaryColorDarkMode =
                CupertinoColors.black.withOpacity(0.3);
            Color primaryColorLightMode = CupertinoColors.systemGrey6;
            Color secondaryColorLightMode =
                CupertinoColors.inactiveGray.withOpacity(0.2);

            var previousColor =
                isDarkMode ? primaryColorDarkMode : primaryColorLightMode;

            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var app in apps.value!)
                    Builder(
                      builder: (context) {
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
                                  Text('${app.id}.'),
                                  SizedBox(width: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: CupertinoColors.black
                                              .withOpacity(0.2),
                                          blurRadius: 10,
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
                                  SizedBox(width: 20),
                                  Text(
                                    getAppNameFromPath(app.path),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  PushButton(
                                    onPressed: () {
                                      ref
                                          .read(appDatabaseNotifierProvider
                                              .notifier)
                                          .deleteApp(app.id);
                                    },
                                    controlSize: ControlSize.regular,
                                    secondary: true,
                                    child: Text('Remove App'),
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
          },
        )
      ],
    );
  }
}
