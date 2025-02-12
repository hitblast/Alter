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

// The AppDatabaseNotifier for handling queries with the database directly from the interface of Alter.
// This is primarily needed for UI synchronization and updates.
@Riverpod(keepAlive: true)
class AppDatabaseNotifier extends _$AppDatabaseNotifier {
  final AppDatabase _database = AppDatabase();
  late StreamSubscription<void> _subscription;
  bool _isSubscriptionListenerEventRunning = false;

  @override
  Future<List<App>> build() async {
    await _database.fetchApps();

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

    return _database.currentApps;
  }

  bool appExists(String path) {
    return state.value!.any((app) => app.path == path);
  }

  // Function to add an app to the database.
  Future<void> addApp(String appPath, String userCustomIconPath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final processedCommand =
          await setCustomIconForApp(appPath, userCustomIconPath);

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

  // Function to update the custom icon for an already added app.
  Future<void> updateAppIcon(
    int id,
    String newCustomIconPath,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final app = await _database.fetchAppById(id);
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

  // Function to remove an app to the database.
  Future<void> deleteApp(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final App? app = await _database.fetchAppById(id);
      await unsetCustomIconForApp(app!);
      await _database.deleteApp(id);
      service.removeWatcher(app.path);
      return _database.currentApps;
    });
  }

  // Function to remove all apps from the database.
  Future<void> deleteAllApps() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      for (final app in _database.currentApps) {
        await unsetCustomIconForApp(app);
      }
      await _database.deleteAllApps();
      service.clearAllWatchers();
      return _database.currentApps;
    });
  }
}
