// Third-party imports.
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The apps page.
// This page is shown if the user has already populated Alter with apps to customize.
class AppsPage extends ConsumerStatefulWidget {
  const AppsPage({super.key});

  @override
  ConsumerState<AppsPage> createState() => _AppsPageState();
}

// The state for the AppsPage widget.
class _AppsPageState extends ConsumerState<AppsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
