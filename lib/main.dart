// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:desktop_window/desktop_window.dart';

// Local imports.
import 'package:alter/core/core_database.dart';
import 'package:alter/models/app_model.dart';
import 'package:alter/pages/error_page.dart';
import 'package:alter/pages/home_page.dart';
import 'package:alter/providers/app_theme_provider.dart';
import 'package:alter/services/background_service.dart';

// Define the Isar database.
late Isar isar;

// Define the background service for Alter.
// This is used for database integrity checks and more.
final BackgroundService service = BackgroundService();

/*

The main application class of Alter.

*/

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    service.start();
  }

  @override
  void dispose() {
    service.stop();
    super.dispose();
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

The main functions of the application.

*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureMacosWindowUtils();
  final dir = await ensureDatabasePath();
  debugPrint('Database is located at: ${dir.path}');

  if (Isar.instanceNames.isEmpty) {
    isar = await Isar.open(
      [
        // The base schema for storing application data.
        AppSchema,
      ],
      directory: dir.path,
      name: 'alterAppListInstance',
      inspector: false,
    );
    debugPrint('Initialized database.');
  }

  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();

  // Set custom desktop window sizes to persist responsiveness on Retina displays.
  await DesktopWindow.setMinWindowSize(const Size(640, 430));
  await DesktopWindow.setWindowSize(const Size(640, 430));

  await config.apply();
}
