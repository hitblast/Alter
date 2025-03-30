// First-party imports.
import 'package:alter/utils/links.dart';
import 'package:flutter/cupertino.dart';

// Third-party imports.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/services/loginitems_service.dart';

/// The macOS sheet view for choosing the icon when the user prompts.
class SettingsSheetPage extends ConsumerStatefulWidget {
  const SettingsSheetPage({super.key});

  @override
  ConsumerState<SettingsSheetPage> createState() => _SettingsSheetPageState();
}

/// The state for the SettingsSheetPage.
class _SettingsSheetPageState extends ConsumerState<SettingsSheetPage> {
  bool _isLaunchAtLoginEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadLaunchAtLoginStatus();
  }

  Future<void> _loadLaunchAtLoginStatus() async {
    try {
      final enabled = await LoginItemsService.isLaunchAtLoginEnabled();
      setState(() {
        _isLaunchAtLoginEnabled = enabled;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _toggleLaunchAtLogin(bool value) async {
    try {
      if (value) {
        await LoginItemsService.enableLaunchAtLogin();
      } else {
        await LoginItemsService.disableLaunchAtLogin();
      }
      setState(() {
        _isLaunchAtLoginEnabled = value;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return MacosSheet(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Launch at Login",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Recommended if you want Alter to constantly check for updates to your modified apps in the background.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: CupertinoColors.systemGrey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            MacosSwitch(
                              value: _isLaunchAtLoginEnabled,
                              onChanged: (value) {
                                _toggleLaunchAtLogin(value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PushButton(
                  controlSize: ControlSize.regular,
                  secondary: true,
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                PushButton(
                  controlSize: ControlSize.regular,
                  child: const Text('Star this project!'),
                  onPressed:
                      () => launchOnWeb(
                        context,
                        'https://github.com/hitblast/Alter',
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
