// First-party imports.
import 'dart:async';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/core_sequences.dart';
import 'package:alter/pages/about_sheet_page.dart';
import 'package:alter/pages/starter_page.dart';
import 'package:alter/providers/app_database_provider.dart';
import 'package:alter/pages/apps_page.dart';

/// The home page of the application.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

/// The state of the home page.
class _HomePageState extends ConsumerState<HomePage> {
  final List<String> _loadingMessages = [
    'This might take a while.',
    'Loading command blocks...',
    'Mining Bitcoin...',
    'Purging annoying icon caches...',
    'Making steak...',
    'Almost there!',
    'Almost...',
    'Oh well.',
    'Incorporating async logic...',
    'Calling DaVinci...',
    'Wowing minions...',
    'Firing engine 01...',
    'Engine stall! Engine stall!'
  ];

  int _currentMessageIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _currentMessageIndex =
            (_currentMessageIndex + 1) % _loadingMessages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var apps = ref.watch(appDatabaseNotifierProvider);

    // Based on the asynchronous state, the page to display is decided.
    if (apps.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProgressCircle(
              radius: 15,
              value: null,
            ),
            const SizedBox(height: 20),
            Text(
              _loadingMessages[_currentMessageIndex],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemGrey,
              ),
            )
          ],
        ),
      );
    } else {
      Widget page;

      // Based on whether the user has modified any apps' icons,
      // either the starter page or the apps page will be displayed.
      if (apps.value!.isEmpty) {
        page = const StarterPage();
      } else {
        page = const AppsPage();
      }

      return PlatformMenuBar(
        menus: [
          PlatformMenu(
            label: 'Alter',
            menus: [
              PlatformMenuItemGroup(
                members: [
                  PlatformMenuItem(
                    label: 'About',
                    onSelected: () => showMacosSheet(
                      context: context,
                      builder: (context) {
                        return AboutSheetPage();
                      },
                    ),
                  ),
                ],
              ),
              PlatformMenuItemGroup(
                members: [
                  PlatformMenuItem(
                    label: 'Kill Process',
                    onSelected: () => initiateKillSequence(context),
                  )
                ],
              ),
              PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.quit,
              )
            ],
          )
        ],
        child: page,
      );
    }
  }
}
