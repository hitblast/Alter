// Third-party imports.
import 'package:isar/isar.dart';

// Generator part file.
part 'app.g.dart';

// The App model.
// Used to store app data in the database.
@collection
class App {
  Id id = Isar.autoIncrement;

  late String path;
  late String customIconPath;
  late String previousCFBundleIconName;
  late String previousCFBundleIconFile;
}
