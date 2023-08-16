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
String _$repositoryHash() => r'4e762fc48ddb22c027309c931fd347bf1068b817';

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
String _$focusedChannelHash() => r'891b3f67768c015ba6ca658ce7a6bff9692ddfa9';

/// See also [focusedChannel].
@ProviderFor(focusedChannel)
final focusedChannelProvider = AutoDisposeFutureProvider<dynamic>.internal(
  focusedChannel,
  name: r'focusedChannelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$focusedChannelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FocusedChannelRef = AutoDisposeFutureProviderRef<dynamic>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
