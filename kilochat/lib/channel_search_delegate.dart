import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model.dart';
import 'providers.dart';
import 'realm_ui/realm_search_delegate.dart';

class ChannelSearchDelegate extends RealmSearchDelegate<Channel> {
  bool _showSubscribed = true;

  ChannelSearchDelegate(super.resultsBuilder, super.itemBuilder);

  @override
  List<Widget> buildActions(BuildContext context) {
    final repository =
        ProviderScope.containerOf(context).read(repositoryProvider).value;
    return [
      if (query.isNotEmpty && repository != null)
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            final channel = repository.createChannel(query.trim());
            repository.subscribeToChannel(channel);
            close(context, null);
          },
        ),
      StatefulBuilder(builder: (_, setState) {
        return Switch(
          value: _showSubscribed,
          onChanged: (value) => setState(() => _showSubscribed = value),
        );
      }),
      ...super.buildActions(context),
    ];
  }
}
