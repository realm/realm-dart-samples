import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:realm_dart/realm.dart';
import 'package:time_track/now_tile.dart';

import 'login_page.dart';
import 'providers.dart';

class EditListPage extends StatefulWidget {
  static const routeName = '/edit';

  const EditListPage({Key? key}) : super(key: key);

  @override
  State<EditListPage> createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  final scrollController = ScrollController();
  late ResultsModel<Now> _model;
  final listKey = GlobalKey<SliverAnimatedListState>();

  @override
  void initState() {
    super.initState();
    _model = ResultsModel<Now>(
      results: realm.allEntriesReversed,
      listKey: listKey,
      removedItemBuilder: (now, _, animation) {
        return NowTile(now: now, animation: animation);
      },
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          realm.write(() => realm.newNow(realm.getCategory(['this', 'is', 'a', 'test'])));
          scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        controller: scrollController,
        shrinkWrap: true,
        reverse: true,
        slivers: <Widget>[
          SliverAnimatedList(
            key: listKey,
            initialItemCount: _model.length,
            itemBuilder: (context, index, animation) {
              final now = _model[index];
              return NowTile(
                key: ValueKey(now.id),
                now: now,
                animation: animation,
                onDismissed: (_) => _model.thaw(now)?.delete(),
              );
            },
          ),
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pushReplacementNamed(LoginPage.routeName),
            ),
            title: const Text('Time Track'),
          ),
        ],
      ),
    );
  }
}

typedef RemovedItemBuilder<E> = Widget Function(E item, BuildContext context, Animation<double> animation);

// Keeps a [RealmResults] in sync with an [AnimatedList].
class ResultsModel<E extends RealmObject> {
  final GlobalKey<SliverAnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;

  late final StreamSubscription _subscription;
  late Realm _liveRealm;
  late RealmResults<E> _frozenResults;

  ResultsModel({
    required this.listKey,
    required this.removedItemBuilder,
    required RealmResults<E> results,
  }) {
    assert(results.isLive);
    _liveRealm = results.realm;
    _frozenResults = results.freeze();
    _subscription = results.changes.listen((c) {
      for (int index in c.deleted.reversed) {
        final old = _frozenResults; // capture current results
        _animatedList.removeItem(
          index,
          (context, animation) => removedItemBuilder(old[index], context, animation),
        );
      }
      _frozenResults = c.results.freeze();
      for (int index in c.inserted) {
        _animatedList.insertItem(index);
      }
    });
  }

  SliverAnimatedListState get _animatedList => listKey.currentState!;

  E operator [](int index) => _frozenResults[index];
  int get length => _frozenResults.length;

  E? thaw(E item) => item.resolveIn(_liveRealm);

  Future<void> dispose() => _subscription.cancel();
}
