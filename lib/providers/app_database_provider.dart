import 'package:alter/models/app.dart';
import 'package:alter/utils/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database_provider.g.dart';

@Riverpod(keepAlive: true)
class AppDatabaseProvider extends _$AppDatabaseProvider {
  late final AppDatabase _database;

  @override
  Future<List<App>> build() async {
    await _database.fetchApps();
    return _database.currentApps;
  }

  Future<void> addApp(
      String pathToAssign, String customIconPathToAssign) async {
    await _database.addApp(pathToAssign, customIconPathToAssign);
  }

  Future<void> updateAppIcon(int id, String newCustomIconPath) async {
    await _database.updateAppIcon(id, newCustomIconPath);
  }

  Future<void> deleteApp(int id) async {
    await _database.deleteApp(id);
  }
}
