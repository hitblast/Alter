// First-party imports.
import 'dart:async';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/pages/starter_page.dart';
import 'package:alter/providers/app_database_provider.dart';
import 'package:alter/pages/apps_page.dart';
import 'package:alter/platform_menus.dart';

// The home page of the application.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

// The state of the home page.
class _HomePageState extends ConsumerState<HomePage> {
  bool _showLoadingMessage = false;

  @override
  void initState() {
    super.initState();
    _startLoadingTimer();
  }

  void _startLoadingTimer() {
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showLoadingMessage = true;
        });
      }
    });
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
            if (_showLoadingMessage)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text("This might take a while"),
              ),
          ],
        ),
      );
    } else {
      Widget page;

      if (apps.value!.isEmpty) {
        page = const StarterPage();
      } else {
        page = const AppsPage();
      }

      return PlatformMenuBar(
        menus: menuBarItems(),
        child: page,
      );
    }
  }
}
