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
  final SnackBar Function(T) builder;

  @override
  State<DisplayToast<T>> createState() => _DisplayToastState<T>();
}

class _DisplayToastState<T> extends State<DisplayToast<T>> {
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(widget.builder(event));
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
