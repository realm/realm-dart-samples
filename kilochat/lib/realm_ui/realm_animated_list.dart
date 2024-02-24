import 'dart:async';

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

typedef ItemWidgetBuilder<E> = Widget Function(
  BuildContext context,
  E item,
  Animation<double> animation,
);

typedef ErrorWidgetBuilder = Widget Function(
  BuildContext context,
  Object? error,
  StackTrace stackTrace,
);

extension<E> on Stream<RealmResultsChanges<E>> {
  Stream<RealmResultsChanges<E>> _updateAnimatedList(
    GlobalKey<AnimatedListState> listKey,
    ItemWidgetBuilder<E> removedItemBuilder,
  ) async* {
    RealmResults<E>? previous;
    await for (final change in this) {
      final state = listKey.currentState;
      if (previous != null) {
        for (final index in change.deleted.reversed) {
          final toDie = previous[index];
          state?.removeItem(
            index,
            (context, animation) =>
                removedItemBuilder(context, toDie, animation),
          );
        }
      }
      for (final index in change.inserted) {
        state?.insertItem(index);
      }
      final r = change.results;
      previous = r.isValid ? r.freeze() : null;
      yield change;
    }
  }
}

class RealmAnimatedList<E> extends StatefulWidget {
  const RealmAnimatedList({
    super.key,
    required this.results,
    required this.itemBuilder,
    ItemWidgetBuilder<E>? removedItemBuilder,
    this.loading,
    this.error,
    this.reverse = false,
    this.controller,
    this.scrollDirection = Axis.vertical,
  }) : removedItemBuilder = removedItemBuilder ?? itemBuilder;
  final RealmResults<E> results;
  final ItemWidgetBuilder<E> itemBuilder;
  final ItemWidgetBuilder<E> removedItemBuilder;

  final WidgetBuilder? loading;
  final ErrorWidgetBuilder? error;

  final bool reverse;
  final ScrollController? controller;
  final Axis scrollDirection;

  @override
  State<RealmAnimatedList> createState() => _RealmAnimatedListState<E>();
}

extension<T> on RealmResults<T> {
  bool get isLive => isValid && !isFrozen;
  Stream<RealmResultsChanges<T>> get safeChanges async* {
    if (isLive) yield* changes;
  }
}

class _RealmAnimatedListState<E> extends State<RealmAnimatedList<E>> {
  final _listKey = GlobalKey<AnimatedListState>();
  StreamSubscription? _subscription;

  void _updateSubscription() {
    _subscription?.cancel();
    _subscription = widget.results.safeChanges
        ._updateAnimatedList(_listKey, widget.removedItemBuilder)
        .listen((_) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _updateSubscription();
  }

  @override
  void didUpdateWidget(covariant RealmAnimatedList<E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.results != oldWidget.results) {
      _updateSubscription();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.results;
    return AnimatedList(
      key: _listKey,
      controller: widget.controller,
      scrollDirection: widget.scrollDirection,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) =>
          index < items.length // why is this needed :-/
              ? widget.itemBuilder(context, items[index], animation)
              : Container(),
      reverse: widget.reverse,
    );
  }
}
