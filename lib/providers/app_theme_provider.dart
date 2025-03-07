// First-party imports.
import 'package:flutter/material.dart';

// Third-party imports.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Provider generator part file.
part 'app_theme_provider.g.dart';

/// The provider for ensuring dynamic theme change of the application.
@riverpod
ThemeMode themeMode(Ref ref) {
  return ThemeMode.system;
}
