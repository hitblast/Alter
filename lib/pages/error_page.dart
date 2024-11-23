import 'package:flutter/cupertino.dart';

class ErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorPage({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Center(
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
