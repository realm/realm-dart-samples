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
    final repository = ref.watch(repositoryProvider);

    final channel = repository.value?.focusedChannel;
    if (channel == null) return const SizedBox.shrink();

    return repository.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (repository) => RealmAnimatedList(
        results: repository.messages(channel),
        itemBuilder: (context, item, animation) {
          return MessageTile(message: item, animation: animation);
        },
        reverse: true,
        controller: scrollController,
      ),
    );
  }
}
