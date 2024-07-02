import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'realm_animated_list.dart';

class RealmSearchDelegate<E> extends SearchDelegate<E?> {
  final RealmResults<E> Function(String query) resultsBuilder;
  final ItemWidgetBuilder<E> itemBuilder;

  RealmSearchDelegate(this.resultsBuilder, this.itemBuilder);

  @override
  List<Widget> buildActions(BuildContext context) {
    // Create a list of actions to display in the app bar
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Create a widget to display as the leading icon in the app bar
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return RealmAnimatedList(
      results: resultsBuilder(query),
      itemBuilder: itemBuilder,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
