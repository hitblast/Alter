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

/// The BackgroundService class for handling background updates to the apps present in the database.
/// This connects with AppDatabaseNotifier with a StreamController to update the user interface
/// (when running in the foreground).
class BackgroundService {
  final StreamController<void> _streamController =
      StreamController<void>.broadcast();
  final Map<DirectoryWatcher, StreamSubscription> _watcherSubscriptions = {};
  final Map<String, Isolate> _runningIsolates = {};
  final Map<String, Timer> _debounceTimers = {};

  // Entrypoint.
  Stream<void> get onAppDataChanged => _streamController.stream;

  /// Start the background service.
  /// Only works if the class is applied as a singleton across the whole app.
  void start() async {
    final apps = await coreIsolateIsar.apps.where().findAll();
    for (final app in apps) {
      addWatcher(app.path);
    }
  }

  /// Stop the background service and the stream controller to prevent further updates.
  void stop() {
    for (final subscription in _watcherSubscriptions.values) {
      subscription.cancel();
    }
    _watcherSubscriptions.clear();
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    _streamController.close();
  }

  /*

  Utility functions.
  Although primarily for external usage, these are also sometimes repeated within the service itself.

  */

  /// Adds a watcher for a specific app path to continuously update if needed.
  void addWatcher(String appPath) async {
    final watcher = DirectoryWatcher(appPath);
    final subscription = watcher.events.listen((event) {
      // Reset the debounce timer every time an event is received.
      if (_debounceTimers.containsKey(appPath)) {
        _debounceTimers[appPath]!.cancel();
      }
      _debounceTimers[appPath] = Timer(Duration(seconds: 10), () {
        _debounceTimers.remove(appPath);
        _runBackgroundCheck(appPath);
      });
    });
    _watcherSubscriptions[watcher] = subscription;
    await watcher.ready;
    debugPrint('Added watcher for path: $appPath');
  }

  /// Removes a watcher and cancels its subscription given an app path.
  void removeWatcher(String appPath) {
    final watchersToRemove = _watcherSubscriptions.keys
        .where((watcher) => watcher.path == appPath)
        .toList();
    for (final watcher in watchersToRemove) {
      // Reset the onData event by canceling the subscription.
      _watcherSubscriptions[watcher]?.cancel();
      _watcherSubscriptions.remove(watcher);
      debugPrint('Removed watcher for path: $appPath');
    }
    if (_debounceTimers.containsKey(appPath)) {
      _debounceTimers[appPath]!.cancel();
      _debounceTimers.remove(appPath);
    }
  }

  /// Clears all watchers and cancels their subscriptions.
  void clearAllWatchers() {
    for (final subscription in _watcherSubscriptions.values) {
      subscription.cancel();
    }
    _watcherSubscriptions.clear();
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    debugPrint('Cleared watchers (possible reset event).');
  }

  /// The primary orchestration function for the background service.
  /// This is responsible for isolate spawning and determining if the UI needs change.
  Future<void> _runBackgroundCheck(String appPath) async {
    if (_runningIsolates.containsKey(appPath)) {
      // This ensure that there is only one running isolate per app at once.
      return;
    }

    final rootToken = RootIsolateToken.instance!;
    final receivePort = ReceivePort();
    final isolateData = {
      'rootToken': rootToken,
      'sendPort': receivePort.sendPort,
      'appPath': appPath,
    };

    // Because Isolate.run() does not give granular access to the API.
    final isolate = await Isolate.spawn(
      _backgroundCheck,
      isolateData,
      debugName: 'alterBackgroundServiceIsolate',
    );
    _runningIsolates[appPath] = isolate;
    debugPrint('Spawned isolate: ${isolate.debugName} for appPath: $appPath');

    receivePort.listen((message) {
      if (message == 'withMods') {
        removeWatcher(appPath);
        _streamController.add(null);
      }
      isolate.kill(priority: Isolate.immediate);
      _runningIsolates.remove(appPath);
    });
  }

  /// The function to be run by _runBackgroundCheck() inside the background service class as a callback.
  /// Raw Isar queries have been used in most places since integrating the provider / database wrapper directly isn't an option.
  static Future<void> _backgroundCheck(Map<String, dynamic> isolateData) async {
    final rootToken = isolateData['rootToken'] as RootIsolateToken;
    final sendPort = isolateData['sendPort'] as SendPort;
    final appPath = isolateData['appPath'] as String;

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);

    Isar isolateIsar = await ensureDatabase();
    debugPrint('Opened database instance for appPath: $appPath');

    bool dataChanged = false;

    final app =
        await isolateIsar.apps.filter().pathEqualTo(appPath).findFirst();
    if (app != null) {
      // If the application does not exist anymore / has been uninstalled.
      final appExists = await Directory(app.path).exists();
      if (!appExists) {
        await isolateIsar
            .writeTxn(() => isolateIsar.apps.delete(app.id));
        dataChanged = true;
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
