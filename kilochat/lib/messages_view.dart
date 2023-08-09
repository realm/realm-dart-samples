import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'realm_ui/realm_animated_list.dart';
import 'tiles.dart';
import 'widget_builders.dart';

class MessagesView extends ConsumerWidget {
  const MessagesView({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(focusedChannelProvider);
    final repository = ref.watch(repositoryProvider);
    return repository.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (repository) => RealmAnimatedList(
        results: repository.messages(channel!),
        itemBuilder: (context, item, animation) {
          return MessageTile(message: item, animation: animation);
        },
        reverse: true,
        controller: scrollController,
      ),
    );
  }
}
