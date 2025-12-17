import 'package:freezed_annotation/freezed_annotation.dart';

part 'commandresult_model.freezed.dart';

@freezed
abstract class CommandResult with _$CommandResult {
  const factory CommandResult({
    required String appBundleId,
    required String customIconPath,
    required String newCFBundleIconName,
    required String newCFBundleIconFile,
    required String previousCFBundleIconName,
    required String previousCFBundleIconFile,
  }) = _CommandResult;
}
