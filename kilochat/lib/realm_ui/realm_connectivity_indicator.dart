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
    final key = ValueKey(current);
    return AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: switch (current) {
          ConnectionState.disconnected => Icon(key: key, Icons.cloud_off),
          ConnectionState.connecting => Icon(key: key, Icons.cloud_sync),
          ConnectionState.connected => Icon(key: key, Icons.cloud_done),
        });
  }
}
