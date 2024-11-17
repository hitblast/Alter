// Import third-party packages.
import 'package:flutter/cupertino.dart';
import 'package:desktop_window/desktop_window.dart';

// Import pages.
import 'package:alter/pages/home_page.dart';
import 'package:macos_ui/macos_ui.dart';

Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureMacosWindowUtils();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<void> setWindowSize() async {
    await DesktopWindow.setMinWindowSize(const Size(600, 400));
    await DesktopWindow.setWindowSize(const Size(600, 400));
    await DesktopWindow.setMaxWindowSize(const Size(600, 400));
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
