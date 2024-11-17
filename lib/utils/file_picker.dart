import 'package:file_selector/file_selector.dart';

Future<XFile?> pickApplication() async {
  final XFile? file = await openFile(initialDirectory: '/Applications');

  // if the file has a .app extension, return the file
  if (file != null && file.path.endsWith('.app')) {
    return file;
  }
  return null;
}
