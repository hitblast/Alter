// First-party imports.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/sequences.dart';
import 'package:alter/pages/settings_sheet_page.dart';
import 'package:alter/utils/links.dart';

/// The starter page widget.
/// This is the first page that the user sees if the have no apps added to the database yet.
class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        enableBlur: true,
        actions: [
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
          const ToolBarSpacer(),
          const ToolBarDivider(),
          const ToolBarSpacer(),
          ToolBarIconButton(
            icon: const MacosIcon(CupertinoIcons.settings_solid),
            label: 'Settings',
            showLabel: false,
            tooltipMessage: 'Open app settings',
            onPressed:
                () => showMacosSheet(
                  context: context,
                  builder: (context) => SettingsSheetPage(),
                ),
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (BuildContext context, scrollController) {
            return GestureDetector(
              onTap: () async => await initiateAppAddingSequence(context),
              child: Center(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Opacity(
                    opacity: 0.78,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MacosIcon(
                          CupertinoIcons.pen,
                          size: 100,
                          color: CupertinoColors.inactiveGray,
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Left-click to start customizing.',
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 21,
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.command,
                              size: 15,
                              color: CupertinoColors.systemGrey,
                            ),
                            Text(
                              ' + Q to put Alter in background.',
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
