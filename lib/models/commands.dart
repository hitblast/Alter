// Third-party imports.
import 'package:freezed_annotation/freezed_annotation.dart';

// Generator part file.
part 'commands.freezed.dart';

// The CommandOnAppAdd model.
// Used to parse command run data while customizing a new app icon.
@freezed
class CommandOnAppAdd with _$CommandOnAppAdd {
  const factory CommandOnAppAdd({
    required String customIconPath,
    required String newCFBundleIconName,
    required String newCFBundleIconFile,
    required String previousCFBundleIconName,
    required String previousCFBundleIconFile,
  }) = _CommandOnAppAdd;
}

// The CommandOnAppUpdate model.
// Used to parse command run data while updating an app icon.
@freezed
class CommandOnAppUpdate with _$CommandOnAppUpdate {
  const factory CommandOnAppUpdate({
    required String newCustomIconPath,
    required String newCFBundleIconName,
    required String newCFBundleIconFile,
  }) = _CommandOnAppUpdate;
}
