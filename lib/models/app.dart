import 'package:isar/isar.dart';

part 'app.g.dart';

@Collection()
class App {
  Id id = Isar.autoIncrement;

  late String path;
  late String customIconPath;
}
