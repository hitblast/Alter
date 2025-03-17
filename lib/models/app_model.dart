// Third-party imports.
import 'package:objectbox/objectbox.dart';

/// The App model.
/// This is an ObjectBox entity - to be used by the database for managing modified app data.
@Entity()
class App {
  // ObjectBox requires your ID property to be an int and annotated with @Id.
  @Id()
  int id;

  String path;
  String appBundleId;
  String customIconPath;
  String newCFBundleIconName;
  String newCFBundleIconFile;
  String previousCFBundleIconName;
  String previousCFBundleIconFile;

  // Provide a default constructor (and optionally a full constructor)
  App({
    this.id = 0,
    required this.path,
    required this.appBundleId,
    required this.customIconPath,
    required this.newCFBundleIconName,
    required this.newCFBundleIconFile,
    required this.previousCFBundleIconName,
    required this.previousCFBundleIconFile,
  });
}
