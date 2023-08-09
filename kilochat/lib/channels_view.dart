import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'channel_search_delegate.dart';
import 'model.dart';
import 'providers.dart';
import 'realm_ui/realm_animated_list.dart';
import 'router.dart';
import 'settings.dart';
import 'tiles.dart';
import 'widget_builders.dart';

class ChannelsView extends ConsumerWidget {
  const ChannelsView({super.key, this.onTap});

  final void Function(Channel)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedChannel = ref.watch(focusedChannelProvider);
    final repository = ref.watch(repositoryProvider);
    return repository.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (repository) {
        final user = repository.user;
        final channels = user.channels.asResults();
        return ListTileTheme(
          data: ListTileThemeData(
            selectedTileColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => Routes.chooseWorkspace.go(context),
                child: Text(currentWorkspace?.name ?? 'No workspace selected'),
              ),
              Expanded(
                child: RealmAnimatedList(
                  results: channels,
                  itemBuilder: (_, channel, animation) => ChannelTile(
                    channel: channel,
                    animation: animation,
                    onTap: () => onTap?.call(channel),
                    onDismissed: (_) =>
                        repository.unsubscribeFromChannel(channel),
                    selected: channel == focusedChannel,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ChannelSearchDelegate(
                      (query) => repository.searchChannel(query),
                      (_, channel, animation) => StatefulBuilder(
                        builder: (_, setState) {
                          return ChannelTile(
                            channel: channel,
                            animation: animation,
                            onTap: () => setState(() {
                              repository.subscribeToChannel(channel);
                            }),
                            selected: !channel.isFrozen &&
                                user.channels.contains(channel),
                          );
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
              const AboutListTile(
                applicationName: 'kilochat',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(Icons.send),
                applicationLegalese: 'Copyright 2023 MongoDB',
                dense: true,
                aboutBoxChildren: [
                  SizedBox(height: 10),
                  Text(
                    'A chat application using Flutter, Realm, and Atlas '
                    'Device Sync. Written in less than 1K lines of code '
                    '(excluding generated code), hence the name.',
                    textScaleFactor: 0.8,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
