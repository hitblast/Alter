// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseNotifierHash() =>
    r'07168a131e299ccb504f597191076c5c4fee87d4';

/// The AppDatabaseNotifier provider for handling queries with the database directly from the interface of Alter.
/// This is primarily needed for UI synchronization and updates.
///
/// Copied from [AppDatabaseNotifier].
@ProviderFor(AppDatabaseNotifier)
final appDatabaseNotifierProvider =
    AsyncNotifierProvider<AppDatabaseNotifier, List<App>>.internal(
  AppDatabaseNotifier.new,
  name: r'appDatabaseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDatabaseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppDatabaseNotifier = AsyncNotifier<List<App>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
