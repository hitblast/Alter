// Third-party imports.
import 'dart:io';

import 'package:alter/providers/app_database_provider.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

// Local imports.
import 'package:alter/utils/file_picker.dart';

// The macOS sheet view for choosing the icon when the user prompts.
class IconChooserSheetPage extends ConsumerStatefulWidget {
  const IconChooserSheetPage({super.key, required this.appFile});

  final XFile appFile;

  @override
  ConsumerState<IconChooserSheetPage> createState() =>
      _IconChooserSheetPageState();
}

// The state for the IconChooserSheetPage.
class _IconChooserSheetPageState extends ConsumerState<IconChooserSheetPage> {
  XFile? currentPickedIcon;

  @override
  Widget build(BuildContext context) {
    final String appName = widget.appFile.name.replaceAll('.app', '');

    return MacosSheet(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose icon for $appName',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                color: CupertinoColors.systemGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  image: AssetImage('assets/alter_icon_frame.png'),
                  width: 155,
                  height: 155,
                ),
                GestureDetector(
                  onTap: () async {
                    final XFile? file = await pickIcon();

                    if (file != null) {
                      setState(() {
                        currentPickedIcon = file;
                      });
                    }
                  },
                  child: Image(
                    image: currentPickedIcon != null
                        ? FileImage(File(currentPickedIcon!.path))
                        : AssetImage('assets/alter_empty.png') as ImageProvider,
                    width: 145,
                    height: 145,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              currentPickedIcon != null
                  ? 'You can modify by left-clicking again!'
                  : 'Left-click above to choose a new icon.',
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PushButton(
                  controlSize: ControlSize.large,
                  secondary: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 10),
                Text('or'),
                SizedBox(width: 10),
                PushButton(
                  controlSize: ControlSize.large,
                  secondary: currentPickedIcon != null ? false : true,
                  onPressed: () {
                    if (currentPickedIcon == null) {
                      return;
                    }
                    ref
                        .read(appDatabaseNotifierProvider.notifier)
                        .addApp(widget.appFile.path, currentPickedIcon!.path);
                    Navigator.of(context).pop();
                  },
                  child: Text('Apply Changes'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
