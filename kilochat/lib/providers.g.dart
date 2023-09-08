// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authHash() => r'bb87fc7829de6f1802b23164ef15da1e22abde8d';

/// See also [auth].
@ProviderFor(auth)
final authProvider =
    AutoDisposeFutureProvider<PasskeyAuth<AuthRequest, AuthResponse>>.internal(
  auth,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRef
    = AutoDisposeFutureProviderRef<PasskeyAuth<AuthRequest, AuthResponse>>;
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
