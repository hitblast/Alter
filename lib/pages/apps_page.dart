// Third-party imports.
import 'package:alter/providers/app_database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

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
    return MacosScaffold(
      toolBar: ToolBar(
        title: const Text('Manage Apps'),
        enableBlur: true,
        actions: [
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.add_circled,
            ),
            label: 'Add',
            showLabel: true,
            onPressed: () =>
                debugPrint('Apps page: Toolbar add button clicked!'),
          ),
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.trash,
            ),
            label: 'Delete All',
            showLabel: true,
            onPressed: () {
              ref.read(appDatabaseNotifierProvider.notifier).deleteAllApps();
            },
          ),
          ToolBarIconButton(
            icon: MacosIcon(
              CupertinoIcons.question_circle,
            ),
            label: 'Help',
            showLabel: true,
            onPressed: () =>
                debugPrint('Apps page: Toolbar help button clicked!'),
          ),
        ],
      ),
    );
  }
}
