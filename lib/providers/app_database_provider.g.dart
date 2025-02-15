// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseNotifierHash() =>
    r'1d87c92bfb51aa6b6dd7319c7b7246f8aaba61a6';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
