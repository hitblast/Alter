// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/pages/starter_page.dart';
import 'package:alter/providers/app_database_provider.dart';
import 'package:alter/pages/apps_page.dart';
import 'package:alter/platform_menus.dart';
import 'package:rive/rive.dart';

// The home page of the application.
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

// The state of the home page.
class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    var apps = ref.watch(appDatabaseNotifierProvider);

    // Based on the asynchronous state, the page to display is decided.
    if (apps.isLoading) {
      final brightness = MediaQuery.of(context).platformBrightness;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.78,
              child: brightness == Brightness.dark
                  ? SizedBox(
                      width: 180,
                      height: 180,
                      child: RiveAnimation.asset(
                        'assets/animations/alter_loading_dark.riv',
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      width: 180,
                      height: 180,
                      child: RiveAnimation.asset(
                        'assets/animations/alter_loading_light.riv',
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 15),
            const ProgressCircle(
              value: null,
            ),
          ],
        ),
      );
    } else {
      Widget page;

      if (apps.value!.isEmpty) {
        page = StarterPage();
      } else {
        page = AppsPage();
      }

      return PlatformMenuBar(
        menus: menuBarItems(),
        child: page,
      );
    }
  }
}
