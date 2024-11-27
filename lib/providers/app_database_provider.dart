// Third-party imports.
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Local imports.
import 'package:alter/core/app_database.dart';
import 'package:alter/core/app_icons.dart';
import 'package:alter/models/app.dart';

// Provider generator part file.
part 'app_database_provider.g.dart';

// Define the provider for the primary database.
@Riverpod(keepAlive: true)
class AppDatabaseNotifier extends _$AppDatabaseNotifier {
  final AppDatabase _database = AppDatabase();

  @override
  Future<List<App>> build() async {
    await _database.fetchApps();
    return _database.currentApps;
  }

  bool appExists(String path) {
    return state.value!.any((app) => app.path == path);
  }

  Future<void> addApp(String appPath, String userCustomIconPath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final processedCommand =
          await setCustomIconForApp(appPath, userCustomIconPath);
      await _database.addApp(
        appPath,
        processedCommand.customIconPath,
        processedCommand.previousCFBundleIconName,
        processedCommand.previousCFBundleIconFile,
      );

      return _database.currentApps;
    });
  }

  Future<void> updateAppIcon(int id, String newCustomIconPath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _database.updateAppIcon(id, newCustomIconPath);
      return _database.currentApps;
    });
  }

  Future<void> deleteApp(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final App? app = await _database.fetchAppById(id);
      await unsetCustomIconForApp(app!);
      await _database.deleteApp(id);
      return _database.currentApps;
    });
  }

  Future<void> deleteAllApps() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _database.deleteAllApps();
      return _database.currentApps;
    });
  }
}
