import 'package:process_run/shell.dart';

Future<void> convertToIcns(String iconPath) async {
  final shell = Shell();
  final iconName = iconPath.split('/').last.split('.').first;
  final parentDirectory =
      iconPath.split('/').sublist(0, iconPath.split('/').length - 1).join('/');
  final newIconPath = "$parentDirectory/$iconName.iconset";

  await shell.run("""
    mkdir $newIconPath
    sips -z 16 16 $iconPath --out $newIconPath/icon_16x16.png
    sips -z 32 32 $iconPath --out $newIconPath/icon_16x16@2x.png
    sips -z 32 32 $iconPath --out $newIconPath/icon_32x32.png
    sips -z 64 64 $iconPath --out $newIconPath/icon_32x32@2x.png
    sips -z 64 64 $iconPath --out $newIconPath/icon_64x64.png
    sips -z 128 128 $iconPath --out $newIconPath/icon_64x64@2x.png
    sips -z 128 128 $iconPath --out $newIconPath/icon_128x128.png
    sips -z 256 256 $iconPath --out $newIconPath/icon_128x128@2x.png
    sips -z 256 256 $iconPath --out $newIconPath/icon_256x256.png
    sips -z 512 512 $iconPath --out $newIconPath/icon_256x256@2x.png
    sips -z 512 512 $iconPath --out $newIconPath/icon_512x512.png
    sips -z 1024 1024 $iconPath --out $newIconPath/icon_512x512@2x.png
    iconutil -c icns $newIconPath
    rm -r $newIconPath
  """);
}
