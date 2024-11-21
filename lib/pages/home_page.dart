// Third-party imports.
import 'package:alter/pages/starter_page.dart';
import 'package:alter/providers/app_database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Local imports.
import 'package:alter/platform_menus.dart';

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

    if (apps.value!.isNotEmpty) {
      return Center(child: Text('Apps found!'));
    }

    return PlatformMenuBar(menus: menuBarItems(), child: StarterPage());
  }
}
