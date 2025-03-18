// First-party imports.
import 'package:flutter/foundation.dart';

// Third-party imports.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:process_run/which.dart';

// Provider generator part file.
part 'app_dependencies_provider.g.dart';

/// Provider to check for missing dependencies.
/// Returns the missing dependencies as a list of strings if any, otherwise null.
@riverpod
Future<List<String>?> missingDependencies(Ref ref) async {
  const requiredDependencies = [
    'chmod',
    'codesign',
    'cp',
    'defaults',
    'iconutil',
    'mkdir',
    'open',
    'osascript',
    'rm',
    'sips',
    'touch',
    'tccutil',
    'xattr',
  ];

  final missingDependencies = <String>[];

  for (final dependency in requiredDependencies) {
    final result = await which(dependency);

    if (result == null) {
      missingDependencies.add(dependency);
      debugPrint("Missing dependency: $dependency");
    } else {
      debugPrint("Dependency found: $dependency at $result");
    }
  }

  return missingDependencies.isEmpty ? null : missingDependencies;
}
