// Third-party imports.
import 'package:flutter/widgets.dart';

// The function for constructing the platform-based menu bar.
List<PlatformMenuItem> menuBarItems() {
  return const [
    PlatformMenu(
      label: 'Alter',
      menus: [
        PlatformProvidedMenuItem(
          type: PlatformProvidedMenuItemType.about,
        ),
        PlatformProvidedMenuItem(
          type: PlatformProvidedMenuItemType.quit,
        )
      ],
    )
  ];
}
