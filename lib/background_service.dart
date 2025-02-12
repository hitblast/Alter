// First-party imports.
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/services.dart';

// Third-party imports.
import 'package:isar/isar.dart';

// Local imports.
import 'package:alter/models/app_model.dart';
import 'package:alter/core/core_database.dart';

// The BackgroundService class for handling background updates to the apps present in the database.
// This connects with AppDatabaseNotifier with a StreamController to update the user interface
// (when running in the foreground).
class BackgroundService {
  final Duration _checkInterval = Duration(minutes: 1);
  Timer? _timer;
  final StreamController<void> _streamController =
      StreamController<void>.broadcast();

  // Entrypoint.
  Stream<void> get onAppDataChanged => _streamController.stream;

  // Start the background service.
  // Only works if the class is applied as a singleton across the whole app.
  void start() {
    _timer = Timer.periodic(_checkInterval, (timer) {
      _runBackgroundCheck();
    });
  }

  // Stop the background service and the stream controller to prevent further updates.
  void stop() {
    _timer?.cancel();
    _streamController.close();
  }

  // The primary orchestration function for the background service.
  // This is responsible for isolate spawning and determining if the UI needs change.
  Future<void> _runBackgroundCheck() async {
    final rootToken = RootIsolateToken.instance!;
    final receivePort = ReceivePort();
    final isolateData = {
      'rootToken': rootToken,
      'sendPort': receivePort.sendPort,
    };

    // Because Isolate.run() does not give granular access to the API.
    final isolate = await Isolate.spawn(_backgroundCheck, isolateData);

    receivePort.listen((message) {
      if (message == 'noMod') {
        isolate.kill(priority: Isolate.immediate);
      } else if (message == 'withMods') {
        _streamController.add(null);
        isolate.kill(priority: Isolate.immediate);
      }
    });
  }

  // The function to be run by _runBackgroundCheck() inside the background service class as a callback.
  // Raw Isar queries have been used in most places since integrating the provider / database wrapper directly isn't an option.
  static Future<void> _backgroundCheck(Map<String, dynamic> isolateData) async {
    final rootToken = isolateData['rootToken'] as RootIsolateToken;
    final sendPort = isolateData['sendPort'] as SendPort;

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
    final dir = await ensureDatabasePath();
    Isar isar = await Isar.open(
      [
        AppSchema,
      ],
      directory: dir.path,
      name: 'alterAppListInstance',
      inspector: false,
    );

    final apps = await isar.apps.where().findAll();
    bool dataChanged = false;

    for (final app in apps) {
      // If the application does not exist anymore / has been uninstalled.
      final appExists = await Directory(app.path).exists();
      if (!appExists) {
        await isar.writeTxn(() => isar.apps.delete(app.id));
        dataChanged = true;
        continue;
      }
    }

    await isar.close();

    if (dataChanged) {
      sendPort.send('withMods');
    } else {
      sendPort.send('noMod');
    }
  }
}
