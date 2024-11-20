// Third-party imports.
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Local imports.
import 'package:alter/models/app.dart';
import 'package:alter/utils/app_database.dart';

// Provider generator part file.
part 'app_database_provider.g.dart';

// Define the provider for the primary database.
@Riverpod(keepAlive: true)
class AppDatabaseProvider extends _$AppDatabaseProvider {
  final AppDatabase database = AppDatabase();

  @override
  Future<List<App>> build() async {
    await database.fetchApps();
    return database.currentApps;
  }

  bool exists(String path) {
    return state.value!.any((app) => app.path == path);
  }

  Future<void> addApp(String path, String customIconPath) async {
    state = AsyncValue.loading();
    state = AsyncValue.guard(() async {
      await database.addApp(path, customIconPath);
      return database.currentApps;
    }) as AsyncValue<List<App>>;
  }

  Future<void> updateAppIcon(int id, String newCustomIconPath) async {
    state = AsyncValue.loading();
    state = AsyncValue.guard(() async {
      await database.updateAppIcon(id, newCustomIconPath);
      return database.currentApps;
    }) as AsyncValue<List<App>>;
  }

  Future<void> deleteApp(int id) async {
    state = AsyncValue.loading();
    state = AsyncValue.guard(() async {
      await database.deleteApp(id);
      return database.currentApps;
    }) as AsyncValue<List<App>>;
  }
}
