import 'package:riverpod_annotation/riverpod_annotation.dart';

// Local imports.
import 'package:alter/models/app.dart';
import 'package:alter/utils/app_database.dart';

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

  bool exists(String path) {
    return state.value!.any((app) => app.path == path);
  }

  Future<void> addApp(String path, String customIconPath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _database.addApp(path, customIconPath);
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
