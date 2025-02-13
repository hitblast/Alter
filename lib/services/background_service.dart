// First-party imports.
import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Third-party imports.
import 'package:isar/isar.dart';
import 'package:watcher/watcher.dart';

// Local imports.
import 'package:alter/main.dart';
import 'package:alter/models/app_model.dart';
import 'package:alter/core/core_database.dart';

// The BackgroundService class for handling background updates to the apps present in the database.
// This connects with AppDatabaseNotifier with a StreamController to update the user interface
// (when running in the foreground).
class BackgroundService {
  final StreamController<void> _streamController =
      StreamController<void>.broadcast();
  final List<DirectoryWatcher> _watchers = [];
  bool _isBackgroundCheckRunning = false;

  // Entrypoint.
  Stream<void> get onAppDataChanged => _streamController.stream;

  // Start the background service.
  // Only works if the class is applied as a singleton across the whole app.
  void start() async {
    final apps = await isar.apps.where().findAll();
    for (final app in apps) {
      addWatcher(app.path);
    }
  }

  // Stop the background service and the stream controller to prevent further updates.
  void stop() {
    _watchers.clear();
    _streamController.close();
  }

  // Utility functions.
  // Although primarily for external usage, these are also sometimes repeated within the service itself.
  void addWatcher(String appPath) async {
    final watcher = DirectoryWatcher(appPath);
    _watchers.add(watcher);
    watcher.events.listen((event) {
      _runBackgroundCheck();
    });
    await watcher.ready;
    debugPrint('Added watcher for path: $appPath');
  }

  void removeWatcher(String appPath) {
    _watchers.removeWhere((watcher) => watcher.path == appPath);
    debugPrint('Removed watcher for path: $appPath');
  }

  void clearAllWatchers() {
    _watchers.clear();
    debugPrint('Cleared watchers (possible reset event).');
  }

  // The primary orchestration function for the background service.
  // This is responsible for isolate spawning and determining if the UI needs change.
  Future<void> _runBackgroundCheck() async {
    if (_isBackgroundCheckRunning) return;
    _isBackgroundCheckRunning = true;

    final rootToken = RootIsolateToken.instance!;
    final receivePort = ReceivePort();
    final isolateData = {
      'rootToken': rootToken,
      'sendPort': receivePort.sendPort,
    };

    // Because Isolate.run() does not give granular access to the API.
    final isolate = await Isolate.spawn(
      _backgroundCheck,
      isolateData,
      debugName: 'alterBackgroundServiceIsolate',
    );
    debugPrint('Spawned isolate: ${isolate.debugName}');

    receivePort.listen((message) {
      if (message == 'withMods') {
        _streamController.add(null);
      }
      isolate.kill(priority: Isolate.immediate);
      _isBackgroundCheckRunning = false;
    });
  }

  // The function to be run by _runBackgroundCheck() inside the background service class as a callback.
  // Raw Isar queries have been used in most places since integrating the provider / database wrapper directly isn't an option.
  static Future<void> _backgroundCheck(Map<String, dynamic> isolateData) async {
    final rootToken = isolateData['rootToken'] as RootIsolateToken;
    final sendPort = isolateData['sendPort'] as SendPort;

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
    final dir = await ensureDatabasePath();
    Isar isolateIsar = await Isar.open(
      [
        AppSchema,
      ],
      directory: dir.path,
      name: 'alterAppListInstance',
      inspector: false,
    );
    debugPrint('Initialized background Isar instance: ${isar.path}');

    final apps = await isolateIsar.apps.where().findAll();
    bool dataChanged = false;

    for (final app in apps) {
      // If the application does not exist anymore / has been uninstalled.
      final appExists = await Directory(app.path).exists();
      if (!appExists) {
        await isolateIsar.writeTxn(() => isolateIsar.apps.delete(app.id));
        dataChanged = true;
        continue;
      }
    }

    await isolateIsar.close();

    if (dataChanged) {
      sendPort.send('withMods');
    } else {
      sendPort.send('noMod');
    }
  }
}
