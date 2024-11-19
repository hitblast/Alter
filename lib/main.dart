// Import third-party packages.
import 'package:flutter/cupertino.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import pages.
import 'package:alter/pages/home_page.dart';
import 'package:macos_ui/macos_ui.dart';

/*

Auxiliary functions for configuring the macOS window.

*/

// Apply macOS design changes.
Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

/*

The main application class of Alter.

*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureMacosWindowUtils();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<void> setWindowSize() async {
    await DesktopWindow.setMinWindowSize(const Size(620, 420));
    await DesktopWindow.setWindowSize(const Size(620, 420));
  }

  @override
  void initState() {
    super.initState();
    setWindowSize();
  }

  @override
  Widget build(BuildContext context) {
    return const MacosApp(
      title: 'Alter',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
