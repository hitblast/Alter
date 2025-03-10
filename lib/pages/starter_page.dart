// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/core_sequences.dart';
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
          builder: (BuildContext context, scrollController) {
            return GestureDetector(
              onTap: () async => await initiateAppAddingSequence(context),
              child: Center(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Opacity(
                        opacity: 0.78,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/alter_starter.png',
                              width: 200,
                              height: 200,
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Left-click to start customizing.',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w300,
                                color: CupertinoColors.systemGrey,
                                letterSpacing: -2,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
