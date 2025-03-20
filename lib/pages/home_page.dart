// First-party imports.
import 'dart:math';
import 'package:alter/utils/links.dart';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/core/sequences.dart';
import 'package:alter/providers/app_database_provider.dart';
import 'package:alter/providers/app_dependencies_provider.dart';
import 'package:alter/pages/apps_page.dart';
import 'package:alter/pages/starter_page.dart';
import 'package:alter/pages/missing_deps_view.dart';

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
    'Engine stall! Engine stall!',
  ];

  final Random _random = Random();
  late String _currentMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var apps = ref.watch(appDatabaseNotifierProvider);
    var missingDependencies = ref.watch(missingDependenciesProvider);

    // Based on the asynchronous state, the page to display is decided.
    if (apps.isLoading || missingDependencies.isLoading) {
      _currentMessage =
          _loadingMessages[_random.nextInt(_loadingMessages.length)];

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProgressCircle(radius: 15, value: null),
            const SizedBox(height: 20),
            Text(
              _currentMessage,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
      );
    } else {
      Widget page;

      // Based on whether the user has modified any apps' icons,
      // either the starter page or the apps page will be displayed.
      if (missingDependencies.value != null) {
        return MissingDepsView(missingDependencies: missingDependencies.value!);
      } else if (apps.value!.isEmpty) {
        page = const StarterPage();
      } else {
        page = const AppsPage();
      }

      return PlatformMenuBar(
        menus: [
          PlatformMenu(
            label: 'Alter',
            menus: [
              PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.about,
              ),
              PlatformMenuItemGroup(
                members: [
                  PlatformMenuItem(
                    label: 'Visit Website',
                    onSelected: () async => await launchOnWeb(context, 'https://hitblast.github.io/Alter'),
                  ),
                ],
              ),
              PlatformMenuItemGroup(
                members: [
                  PlatformMenuItem(
                    label: 'Kill Alter',
                    onSelected: () => initiateKillSequence(context),
                  ),
                  PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.hide,
                  ),
                  PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.minimizeWindow,
                  ),
                ],
              ),
              PlatformProvidedMenuItem(type: PlatformProvidedMenuItemType.quit),
            ],
          ),
        ],
        child: page,
      );
    }
  }
}
