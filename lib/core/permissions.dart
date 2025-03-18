// First-party imports.
import 'package:flutter/foundation.dart';

// Third-party imports.
import 'package:process_run/shell.dart';

/// Resets system-granted permissions for the app - given its absolute path.
/// This is essential for execution when the code signature for a particular app has been changed.
/// Returns the bundle ID of the app if successful, otherwise an empty string.
Future<String> resetPermissions(String appPath) async {
  final shell = Shell();

  try {
    final appBundleId =
        (await shell.run("""
            /usr/bin/osascript -e 'id of app "$appPath"'
        """)).single.outText;

    // Call tccutil to reset.
    await shell.run('/usr/bin/tccutil reset All $appBundleId');
    debugPrint('Reset permissions for bundle ID: $appBundleId');

    return appBundleId;
  } catch (_) {
    return '';
  }
}
