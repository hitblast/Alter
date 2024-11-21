// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:path_provider/path_provider.dart';

// Local imports.
import 'package:alter/models/app.dart';
import 'package:alter/pages/home_page.dart';

/*

Important parts.

*/

// Define the Isar database.
late Isar isar;

// Apply macOS design changes.
Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

/*

The main application class of Alter.

*/

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<void> setWindowSize() async {
    await DesktopWindow.setMinWindowSize(const Size(640, 430));
    await DesktopWindow.setWindowSize(const Size(640, 430));
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

/*

The main function of the application.

*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureMacosWindowUtils();

  final dir = await getApplicationDocumentsDirectory();
  if (Isar.instanceNames.isEmpty) {
    isar = await Isar.open(
      [AppSchema],
      directory: dir.path,
      name: 'alterInstance',
    );
  }

  runApp(ProviderScope(child: const MainApp()));
}
