// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The AppDatabaseNotifier provider for handling queries with the database directly from the interface of Alter.
/// This is primarily needed for UI synchronization and updates.

@ProviderFor(AppDatabaseNotifier)
const appDatabaseProvider = AppDatabaseNotifierProvider._();

/// The AppDatabaseNotifier provider for handling queries with the database directly from the interface of Alter.
/// This is primarily needed for UI synchronization and updates.
final class AppDatabaseNotifierProvider
    extends $AsyncNotifierProvider<AppDatabaseNotifier, List<App>> {
  /// The AppDatabaseNotifier provider for handling queries with the database directly from the interface of Alter.
  /// This is primarily needed for UI synchronization and updates.
  const AppDatabaseNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseNotifierHash();

  @$internal
  @override
  AppDatabaseNotifier create() => AppDatabaseNotifier();
}

String _$appDatabaseNotifierHash() =>
    r'926cf251c1ae06d876ebbc88028c60777de15e8c';

/// The AppDatabaseNotifier provider for handling queries with the database directly from the interface of Alter.
/// This is primarily needed for UI synchronization and updates.

abstract class _$AppDatabaseNotifier extends $AsyncNotifier<List<App>> {
  FutureOr<List<App>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<App>>, List<App>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<App>>, List<App>>,
              AsyncValue<List<App>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
