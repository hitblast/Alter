// Third-party imports.
import 'package:rive/rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/app_core.dart';
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
                    padding: const EdgeInsets.all(20),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Opacity(
                        opacity: 0.78,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 280,
                              height: 280,
                              child: RiveAnimation.asset(
                                'assets/animations/alter_starter_screen.riv',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const Text(
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
