// First-party imports.
import 'package:flutter/cupertino.dart';

// Third-party icons.
import 'package:url_launcher/url_launcher.dart';

// Local imports.
import 'package:alter/utils/dialogs.dart';

/// The function to launch a URL.
Future<void> launchOnWeb(BuildContext context, String url) async {
  Uri uri = Uri.parse(url);
  late bool hasLaunchedURL;

  try {
    hasLaunchedURL = await launchUrl(uri);
  } catch (_) {
    hasLaunchedURL = false;
  }

  if (!hasLaunchedURL && context.mounted) {
    showAlertDialog(context, 'Could not show page.',
        'Please make sure your browser and internet connection are properly set up.');
  }
}
