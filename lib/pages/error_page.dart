// First-party imports.
import 'package:flutter/cupertino.dart';

/// A simple page for when the app encounters an error and crashes.
/// This might later be elaborated with sending debug logs to server and more.
class ErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorPage({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '!',
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
