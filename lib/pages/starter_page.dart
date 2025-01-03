// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/app_core.dart';
import 'package:alter/pages/help_sheet_page.dart';
import 'package:alter/utils/launch_url.dart';

// The starter page widget.
// This is the first page that the user sees if the have no apps added to the database yet.
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
              CupertinoIcons.globe,
            ),
            label: 'Get Icons',
            showLabel: true,
            onPressed: () async => await launchGetIconsPageOnWeb(context),
          ),
          ToolBarIconButton(
            icon: const MacosIcon(
              CupertinoIcons.question_circle,
            ),
            label: 'Help',
            showLabel: true,
            onPressed: () async => showMacosSheet(
              context: context,
              builder: (context) {
                return HelpSheetPage();
              },
            ),
          ),
        ],
      ),
      children: [
        ContentArea(
          builder: (BuildContext context, scrollController) {
            return GestureDetector(
              onTap: () async {
                await initiateAppAddingSequence(context);
              },
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
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Opacity(
                        opacity: 0.78,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MacosIcon(
                              CupertinoIcons.add_circled_solid,
                              color: CupertinoColors.systemGrey,
                              size: 100,
                            ),
                            SizedBox(height: 25),
                            Text(
                              'Left-click to start customizing.',
                              style: TextStyle(
                                fontSize: 25,
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
