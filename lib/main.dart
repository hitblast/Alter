// Third-party imports.
import 'package:alter/providers/app_theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:path_provider/path_provider.dart';

// Local imports.
import 'package:alter/pages/error_page.dart';
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

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
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
    return MacosApp(
      title: 'Alter',
      themeMode: ref.watch(themeModeProvider),
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return ErrorPage(
            errorDetails: errorDetails,
          );
        };
        return widget ?? Container();
      },
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
      [
        // The base schema for storing application data.
        AppSchema,
      ],
      directory: dir.path,
      name: 'alterInstance',
    );
  }

  runApp(ProviderScope(child: const MainApp()));
}
