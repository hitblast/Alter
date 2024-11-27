// Third-party imports.
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Provider generator part file.
part 'app_theme_provider.g.dart';

// Define the provider for the theme mode.
@riverpod
ThemeMode themeMode(ThemeModeRef ref) {
  return ThemeMode.system;
}
