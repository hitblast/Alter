// First-party imports.
import 'package:flutter/foundation.dart';

// Third-party imports.
import 'package:process_run/shell.dart';

// Local imports.
import 'package:alter/utils/funcs.dart' as funcs;

/// Resets system-granted permissions for the app given its path.
/// This is essential for execution when the code signature for a particular app has been changed.
/// Returns the bundle ID of the app which the permissions have been reset for.
Future<String> resetPermissionsByAppPath(String appPath) async {
  final shell = Shell();
  final appBundleId = await funcs.getBundleIdByAppPath(appPath);

  try {
    await shell.run('/usr/bin/tccutil reset All $appBundleId');
  } catch (e) {
    debugPrint('Failed to reset permissions for bundle ID: $appBundleId');
  }

  return appBundleId;
}
