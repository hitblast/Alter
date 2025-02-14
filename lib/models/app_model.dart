// Third-party imports.
import 'package:isar/isar.dart';

// Generator part file.
part 'app_model.g.dart';

/// The App model.
/// Used to store app data in Alter's database.
@collection
class App {
  Id id = Isar.autoIncrement;

  late String path;
  late String customIconPath;
  late String newCFBundleIconName;
  late String newCFBundleIconFile;
  late String previousCFBundleIconName;
  late String previousCFBundleIconFile;
}
