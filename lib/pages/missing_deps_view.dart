// First-party imports.
import 'dart:io';

import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:macos_ui/macos_ui.dart';

/// A simple view for when dependencies are deemed missing during runtime.
/// Receives a list of strings representing the missing dependencies.
class MissingDepsView extends StatelessWidget {
  final List<String> missingDependencies;

  const MissingDepsView({super.key, required this.missingDependencies});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_circle_fill,
              color: CupertinoColors.systemRed,
              size: 40,
            ),
            const SizedBox(height: 10),
            const Text(
              'Missing dependencies!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemGrey,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'The following dependencies are required for Alter to run: ${missingDependencies.join(', ')}.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            PushButton(
              onPressed: () => exit(0),
              controlSize: ControlSize.large,
              secondary: true,
              child: Text('Close application'),
            ),
          ],
        ),
      ),
    );
  }
}
