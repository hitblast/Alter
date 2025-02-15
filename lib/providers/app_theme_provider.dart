// First-party imports.
import 'package:flutter/material.dart';

// Third-party imports.
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Provider generator part file.
part 'app_theme_provider.g.dart';

/// The provider for ensuring dynamic theme change of the application.
@riverpod
ThemeMode themeMode(ThemeModeRef ref) {
  return ThemeMode.system;
}
