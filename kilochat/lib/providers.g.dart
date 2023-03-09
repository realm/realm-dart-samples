// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appHash() => r'b3bc4e02df3b254bcad8a3e6db9f2030a06a0ce4';

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
String _$localRealmHash() => r'31ba36028bf0e66b3453c3e4a89113e0e6ed5e92';

/// See also [localRealm].
@ProviderFor(localRealm)
final localRealmProvider = AutoDisposeFutureProvider<Realm>.internal(
  localRealm,
  name: r'localRealmProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$localRealmHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalRealmRef = AutoDisposeFutureProviderRef<Realm>;
String _$messagesHash() => r'c191f05ca61d99c07b2cd9d267be737b75892d5c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef MessagesRef = AutoDisposeStreamProviderRef<RealmResults<dynamic>>;

/// See also [messages].
@ProviderFor(messages)
const messagesProvider = MessagesFamily();

/// See also [messages].
class MessagesFamily extends Family<AsyncValue<RealmResults<dynamic>>> {
  /// See also [messages].
  const MessagesFamily();

  /// See also [messages].
  MessagesProvider call(
    dynamic channel,
  ) {
    return MessagesProvider(
      channel,
    );
  }

  @override
  MessagesProvider getProviderOverride(
    covariant MessagesProvider provider,
  ) {
    return call(
      provider.channel,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messagesProvider';
}

/// See also [messages].
class MessagesProvider
    extends AutoDisposeStreamProvider<RealmResults<dynamic>> {
  /// See also [messages].
  MessagesProvider(
    this.channel,
  ) : super.internal(
          (ref) => messages(
            ref,
            channel,
          ),
          from: messagesProvider,
          name: r'messagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messagesHash,
          dependencies: MessagesFamily._dependencies,
          allTransitiveDependencies: MessagesFamily._allTransitiveDependencies,
        );

  final dynamic channel;

  @override
  bool operator ==(Object other) {
    return other is MessagesProvider && other.channel == channel;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channel.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$repositoryHash() => r'9735e5fd79954002433a9b2b517fa72087982b00';

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
String _$syncedRealmHash() => r'9554cdc8a5829d0efa00aaade4fa4915c85f7f69';

/// See also [syncedRealm].
@ProviderFor(syncedRealm)
final syncedRealmProvider = AutoDisposeFutureProvider<Realm>.internal(
  syncedRealm,
  name: r'syncedRealmProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncedRealmHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SyncedRealmRef = AutoDisposeFutureProviderRef<Realm>;
String _$userHash() => r'3162f8129e247644d301b4259e2b47c828d85eb4';

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
String _$userProfileHash() => r'33b2c3a07b2745665b33664efb14839edf046050';

/// See also [userProfile].
@ProviderFor(userProfile)
final userProfileProvider = AutoDisposeStreamProvider<dynamic>.internal(
  userProfile,
  name: r'userProfileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserProfileRef = AutoDisposeStreamProviderRef<dynamic>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
