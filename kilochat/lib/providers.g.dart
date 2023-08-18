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
String _$userHash() => r'01d81be0d3b467561310f13c6d871e58fd8d8728';

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
String _$repositoryHash() => r'2275ebf66658e7b0d08ad325b5ea8aacacf4143a';

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
String _$focusedChannelHash() => r'c467f8b8fbe8c481f8f49a542486227febaa2684';

/// See also [focusedChannel].
@ProviderFor(focusedChannel)
final focusedChannelProvider = AutoDisposeStreamProvider<dynamic>.internal(
  focusedChannel,
  name: r'focusedChannelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$focusedChannelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FocusedChannelRef = AutoDisposeStreamProviderRef<dynamic>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
