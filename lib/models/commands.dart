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
