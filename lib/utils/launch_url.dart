// Third-party icons.
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

// Local imports.
import 'package:alter/utils/dialogs.dart';

// The function to launch a URL.
Future<bool> _launchOnWeb(String url) async {
  Uri uri = Uri.parse(url);
  return await launchUrl(uri);
}

// The function to launch the help page.
Future<void> launchHelpPageOnWeb(BuildContext context) async {
  if (!await _launchOnWeb('https://hitblastis.me')) {
    if (!context.mounted) return;
    showAlertDialog(context, 'Cannot show help page.',
        'Make sure you have a proper internet connection and try again.');
  }
}

// The function to launch the icons page.
Future<void> launchGetIconsPageOnWeb(BuildContext context) async {
  if (!await _launchOnWeb('https://macosicons.com')) {
    if (!context.mounted) return;
    showAlertDialog(context, 'Cannot show icons page.',
        'Make sure you have a proper internet connection and try again.');
  }
}
