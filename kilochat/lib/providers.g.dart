// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appHash() => r'f2013a10f035b47580fa754eb5b97b53d77ee6d2';

/// See also [app].
@ProviderFor(app)
final appProvider = AutoDisposeStreamProvider<App>.internal(
  app,
  name: r'appProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRef = AutoDisposeStreamProviderRef<App>;
String _$userHash() => r'9500263a0a8bbe86ba3186a23b7ea55f651338f6';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeStreamProvider<User>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeStreamProviderRef<User>;
String _$repositoryHash() => r'ba79d3db0c045d0c101373e89a1ce4172155a75a';

/// See also [repository].
@ProviderFor(repository)
final repositoryProvider = AutoDisposeFutureProvider<Repository>.internal(
  repository,
  name: r'repositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$repositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RepositoryRef = AutoDisposeFutureProviderRef<Repository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
