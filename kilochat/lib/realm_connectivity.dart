import 'package:flutter/material.dart' hide ConnectionState;
import 'package:realm/realm.dart';

class RealmConnectivityIndicator extends StatelessWidget {
  const RealmConnectivityIndicator({
    super.key,
    this.builder = _defaultBuilder,
    required this.changes,
  });

  final Widget Function(ConnectionStateChange connectionState) builder;
  final Stream<ConnectionStateChange> changes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: changes,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return data != null ? builder(data) : const SizedBox.shrink();
      },
    );
  }

  static Widget _defaultBuilder(ConnectionStateChange connectionState) {
    final current = connectionState.current;
    return AnimatedSwitcher(
        key: ValueKey(current),
        duration: kThemeAnimationDuration,
        child: switch (current) {
          ConnectionState.disconnected => const Icon(Icons.cloud_off),
          ConnectionState.connecting => const Icon(Icons.cloud_sync),
          ConnectionState.connected => const Icon(Icons.cloud_done),
        });
  }
}
