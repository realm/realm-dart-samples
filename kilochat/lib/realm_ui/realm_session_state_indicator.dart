import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' hide ConnectionState;
import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';

typedef SessionStatus = (
  bool connected,
  ConnectionState state,
  bool downloading,
  bool uploading
);

class RealmSessionStateIndicator extends StatelessWidget {
  const RealmSessionStateIndicator({
    super.key,
    required this.session,
    this.builder = _defaultBuilder,
    this.duration = const Duration(seconds: 1),
  });

  final Widget Function(SessionStatus status) builder;
  final Session session;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        return AnimatedSwitcher(
          duration: duration,
          child: data == null ? const SizedBox.shrink() : builder(data),
        );
      },
    );
  }

  Stream<SessionStatus> _stream() async* {
    yield* CombineLatestStream.combine4(
        Connectivity()
            .onConnectivityChanged
            .startWith(await Connectivity().checkConnectivity()),
        session.connectionStateChanges
            .map((c) => c.current)
            .startWith(session.connectionState),
        session.getProgressStream(
          ProgressDirection.download,
          ProgressMode.reportIndefinitely,
        ),
        session.getProgressStream(
          ProgressDirection.upload,
          ProgressMode.reportIndefinitely,
        ),
        (connectivity, state, download, upload) => (
              connectivity != ConnectivityResult.none,
              state,
              download.transferableBytes > download.transferredBytes,
              upload.transferredBytes > upload.transferableBytes,
            )).distinct();
  }

  static Widget _defaultBuilder(SessionStatus status) {
    final iconData = switch (status) {
      (false, ConnectionState.disconnected, _, _) => Icons.block,
      (false, _, _, _) => Icons.cloud_off,
      (_, ConnectionState.disconnected, _, _) => Icons.cloud_off,
      (_, ConnectionState.connecting, _, _) => Icons.cloud_queue,
      (_, ConnectionState.connected, true, _) => Icons.cloud_download,
      (_, ConnectionState.connected, _, true) => Icons.cloud_upload,
      (_, ConnectionState.connected, false, false) => Icons.cloud_done,
    };
    return Icon(iconData, key: ValueKey(iconData));
  }
}
