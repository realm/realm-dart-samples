// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authHash() => r'e2d649ccf2244021dd2bb2cc2355b835a9957a3c';

/// See also [auth].
@ProviderFor(auth)
final authProvider = AutoDisposeFutureProvider<CorbadoAuth>.internal(
  auth,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRef = AutoDisposeFutureProviderRef<CorbadoAuth>;
String _$repositoryHash() => r'6fed4ac6e5b8977a4ad0c215b8030845a217b1b3';

/// See also [repository].
@ProviderFor(repository)
final repositoryProvider = AutoDisposeStreamProvider<Repository>.internal(
  repository,
  name: r'repositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$repositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RepositoryRef = AutoDisposeStreamProviderRef<Repository>;
String _$focusedChannelHash() => r'4c82030fe34b65448b7f640cf1009d6518b34993';

/// See also [focusedChannel].
@ProviderFor(focusedChannel)
final focusedChannelProvider = AutoDisposeStreamProvider<Channel?>.internal(
  focusedChannel,
  name: r'focusedChannelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$focusedChannelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FocusedChannelRef = AutoDisposeStreamProviderRef<Channel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member