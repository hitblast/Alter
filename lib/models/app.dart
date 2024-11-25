import 'package:isar/isar.dart';

part 'app.g.dart';

@collection
class App {
  Id id = Isar.autoIncrement;

  late String path;
  late String customIconPath;
}
