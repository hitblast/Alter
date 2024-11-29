// Third-party imports.
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:path_provider/path_provider.dart';

// Local imports.
import 'package:alter/models/app.dart';
import 'package:alter/pages/error_page.dart';
import 'package:alter/pages/home_page.dart';
import 'package:alter/providers/app_theme_provider.dart';

// Define the Isar database.
late Isar isar;

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

  final applicationDocumentsDirectory =
      await getApplicationDocumentsDirectory();
  final dir = Directory('${applicationDocumentsDirectory.path}/Alter');

  if (!(await dir.exists())) {
    await dir.create();
  }

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

Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}
