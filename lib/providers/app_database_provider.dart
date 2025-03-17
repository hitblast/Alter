// First-party imports.
import 'dart:async';

// Third-party imports.
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Local imports.
import 'package:alter/main.dart';
import 'package:alter/core/core_database.dart';
import 'package:alter/core/core_icons.dart';
import 'package:alter/models/app_model.dart';

// Provider generator part file.
part 'app_database_provider.g.dart';

/// The AppDatabaseNotifier provider for handling queries with the database directly from the interface of Alter.
/// This is primarily needed for UI synchronization and updates.
@Riverpod(keepAlive: true)
class AppDatabaseNotifier extends _$AppDatabaseNotifier {
  final AppDatabase _database = AppDatabase();
  late StreamSubscription<void> _subscription;
  bool _isSubscriptionListenerEventRunning = false;

  @override
  Future<List<App>> build() async {
    // Integration with services/background_service.dart for database integrity.
    _subscription = service.onAppDataChanged.listen((_) async {
      if (!_isSubscriptionListenerEventRunning) {
        _isSubscriptionListenerEventRunning = true;
        state = await AsyncValue.guard(() async {
          await _database.fetchApps();
          return _database.currentApps;
        });
        _isSubscriptionListenerEventRunning = false;
      }
    });

    ref.onDispose(() {
      _subscription.cancel();
    });

    await _database.fetchApps();
    return _database.currentApps;
  }

  /// Function to add an app to the database.
  Future<void> addApp(String appPath, String userCustomIconPath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final processedCommand = await setCustomIconForApp(
        appPath,
        userCustomIconPath,
      );

      if (processedCommand != null) {
        await _database.addApp(
          appPath,
          processedCommand.customIconPath,
          processedCommand.newCFBundleIconName,
          processedCommand.newCFBundleIconFile,
          processedCommand.previousCFBundleIconName,
          processedCommand.previousCFBundleIconFile,
        );
        service.addWatcher(appPath);
      }

      return _database.currentApps;
    });
  }

  /// Function to update the custom icon for an already added app.
  Future<void> updateAppIcon(int id, String newCustomIconPath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final app = await _database.getAppById(id);
      final processedCommand = await setCustomIconForApp(
        app!.path,
        newCustomIconPath,
        iconToDelete: app.newCFBundleIconFile,
      );

      if (processedCommand != null) {
        await _database.updateAppIcon(
          id,
          processedCommand.customIconPath,
          processedCommand.newCFBundleIconName,
          processedCommand.newCFBundleIconFile,
        );
      }
      return _database.currentApps;
    });
  }

  /// Function to remove an app from the database.
  Future<void> deleteApp(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final App? app = await _database.getAppById(id);
      service.removeWatcher(app!.path);

      try {
        await unsetCustomIconForApp(app);
      } catch (_) {} 

      await _database.deleteApp(id);
      return _database.currentApps;
    });
  }

  /// Function to remove all apps from the database.
  Future<void> deleteAllApps() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      for (final app in _database.currentApps) {
        try {
          await unsetCustomIconForApp(app);
        } catch (_) {} 
      }

      await _database.deleteAllApps();
      service.clearAllWatchers();
      return _database.currentApps;
    });
  }
}
