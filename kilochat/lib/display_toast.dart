import 'dart:async';

import 'package:flutter/material.dart';

class DisplayToast<T> extends StatefulWidget {
  const DisplayToast({
    super.key,
    required this.child,
    required this.stream,
    required this.builder,
  });

  final Widget child;
  final Stream<T> stream;
  final Widget Function(T, Animation<double> animation) builder;

  @override
  State<DisplayToast<T>> createState() => _DisplayToastState<T>();
}

class _DisplayToastState<T> extends State<DisplayToast<T>>
    with TickerProviderStateMixin {
  final _overlayKey = GlobalKey<OverlayState>();
  late final AnimationController _controller;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _subscription = widget.stream.asyncMap((event) async {
      final entry = _buildOverlayEntry(event);
      final state = _overlayKey.currentState;
      if (state != null) {
        state.insert(entry);
        await _controller.forward();
        await Future.delayed(const Duration(seconds: 3));
        await _controller.reverse();
        entry.remove();
      }
    }).listen((_) {});
  }

  OverlayEntry _buildOverlayEntry(event) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: 10,
        right: 10,
        top: 10,
        child: FadeTransition(
          opacity: _controller,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
              boxShadow: kElevationToShadow[4],
              color: Colors.grey.withAlpha(100),
            ),
            child: widget.builder(event, _controller),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        IgnorePointer(child: Overlay(key: _overlayKey)),
      ],
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }
}
