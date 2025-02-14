// Third-party imports.
import 'package:freezed_annotation/freezed_annotation.dart';

// Generator part file.
part 'commandresult_model.freezed.dart';

/// The CommandResult model.
/// This is used to parse command run data while customizing a new app icon.
@freezed
class CommandResult with _$CommandResult {
  const factory CommandResult({
    required String customIconPath,
    required String newCFBundleIconName,
    required String newCFBundleIconFile,
    required String previousCFBundleIconName,
    required String previousCFBundleIconFile,
  }) = _CommandResult;
}
