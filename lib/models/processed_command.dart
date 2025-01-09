// Third-party imports.
import 'package:freezed_annotation/freezed_annotation.dart';

// Generator part file.
part 'processed_command.freezed.dart';

// The ProcessedCommand model.
// Used to relay back command execution data for storing in the database.
@freezed
class ProcessedCommand with _$ProcessedCommand {
  const factory ProcessedCommand({
    required String customIconPath,
    required String newCFBundleIconName,
    required String newCFBundleIconFile,
    required String previousCFBundleIconName,
    required String previousCFBundleIconFile,
  }) = _ProcessedCommand;
}
