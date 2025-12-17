// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_dependencies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to check for missing dependencies.
/// Returns the missing dependencies as a list of strings if any, otherwise null.

@ProviderFor(missingDependencies)
const missingDependenciesProvider = MissingDependenciesProvider._();

/// Provider to check for missing dependencies.
/// Returns the missing dependencies as a list of strings if any, otherwise null.

final class MissingDependenciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>?>,
          List<String>?,
          FutureOr<List<String>?>
        >
    with $FutureModifier<List<String>?>, $FutureProvider<List<String>?> {
  /// Provider to check for missing dependencies.
  /// Returns the missing dependencies as a list of strings if any, otherwise null.
  const MissingDependenciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'missingDependenciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$missingDependenciesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>?> create(Ref ref) {
    return missingDependencies(ref);
  }
}

String _$missingDependenciesHash() =>
    r'ac0caeaf465cb9b6716591f2eb8b51d10d3011ca';
