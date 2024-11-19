// Third-party imports.
import 'dart:io';

import 'package:alter/utils/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macos_ui/macos_ui.dart';

// The macOS sheet view for choosing the icon when the user prompts.
class IconChooserSheetPage extends StatefulWidget {
  const IconChooserSheetPage({super.key, required this.appFile});

  final XFile appFile;

  @override
  State<IconChooserSheetPage> createState() => _IconChooserSheetPageState();
}

// The state for the IconChooserSheetPage.
class _IconChooserSheetPageState extends State<IconChooserSheetPage> {
  XFile? currentPickedIcon;

  @override
  Widget build(BuildContext context) {
    final String appName = widget.appFile.name.replaceAll('.app', '');

    return MacosSheet(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose icon for $appName',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: currentPickedIcon != null
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.inactiveGray,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: GestureDetector(
                onTap: () async {
                  final XFile? file = await pickIcon();

                  if (file != null) {
                    setState(() {
                      currentPickedIcon = file;
                    });
                  }
                },
                child: currentPickedIcon != null
                    ? Image.file(
                        File(currentPickedIcon!.path),
                        width: 145,
                        height: 145,
                      )
                    : Image(
                        image: AssetImage('assets/alter_empty.png'),
                        width: 145,
                        height: 145,
                      ),
              ),
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
                PushButton(
                  controlSize: ControlSize.large,
                  secondary: currentPickedIcon != null ? false : true,
                  onPressed: () {
                    if (currentPickedIcon == null) {
                      return;
                    }
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
