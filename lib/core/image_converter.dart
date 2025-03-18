// First-party imports.
import 'dart:io';

// Third-party imports.
import 'package:path/path.dart' as path;
import 'package:process_run/shell.dart';

/// The function to convert a given PNG image to ICNS.
Future<File> convertToIcns(String iconPath) async {
  final shell = Shell();
  final iconName = iconPath.split('/').last.split('.').first;
  final parentDir = Directory(iconPath).parent.path;
  final newIconPath = path.join(parentDir, '$iconName.iconset');

  await shell.run("""
    /bin/mkdir "$newIconPath"
    /usr/bin/sips -z 16 16 "$iconPath" --out "$newIconPath/icon_16x16.png"
    /usr/bin/sips -z 32 32 "$iconPath" --out "$newIconPath/icon_16x16@2x.png"
    /usr/bin/sips -z 32 32 "$iconPath" --out "$newIconPath/icon_32x32.png"
    /usr/bin/sips -z 64 64 "$iconPath" --out "$newIconPath/icon_32x32@2x.png"
    /usr/bin/sips -z 64 64 "$iconPath" --out "$newIconPath/icon_64x64.png"
    /usr/bin/sips -z 128 128 "$iconPath" --out "$newIconPath/icon_64x64@2x.png"
    /usr/bin/sips -z 128 128 "$iconPath" --out "$newIconPath/icon_128x128.png"
    /usr/bin/sips -z 256 256 "$iconPath" --out "$newIconPath/icon_128x128@2x.png"
    /usr/bin/sips -z 256 256 "$iconPath" --out "$newIconPath/icon_256x256.png"
    /usr/bin/sips -z 512 512 "$iconPath" --out "$newIconPath/icon_256x256@2x.png"
    /usr/bin/sips -z 512 512 "$iconPath" --out "$newIconPath/icon_512x512.png"
    /usr/bin/sips -z 1024 1024 "$iconPath" --out "$newIconPath/icon_512x512@2x.png"
    /usr/bin/iconutil -c icns "$newIconPath"
    /bin/rm -r "$newIconPath"
  """);

  return File("$parentDir/$iconName.icns");
}
