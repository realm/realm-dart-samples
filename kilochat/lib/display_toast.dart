import 'dart:async';

import 'package:flutter/material.dart';

class DisplayToast<T> extends StatefulWidget {
  const DisplayToast({
    Key? key,
    required this.child,
    required this.stream,
    required this.builder,
  }) : super(key: key);

  final Widget child;
  final Stream<T> stream;
  final Widget Function(T, Animation<double> animation) builder;

  @override
  State<DisplayToast<T>> createState() => _DisplayToastState<T>();
}

class _DisplayToastState<T> extends State<DisplayToast<T>>
    with TickerProviderStateMixin {
  late StreamSubscription _subscription;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  final _overlayKey = GlobalKey<OverlayState>();

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.asyncMap((event) async {
      final entry = OverlayEntry(
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
                color: Colors.white,
              ),
              child: widget.builder(event, _controller),
            ),
          ),
        ),
      );
      final state = _overlayKey.currentState;
      if (state != null) {
        state.insert(entry);
        _controller.reset();
        await _controller.forward();
        await Future.delayed(const Duration(seconds: 3));
        await _controller.reverse();
        entry.remove();
      }
    }).listen((_) {});
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
