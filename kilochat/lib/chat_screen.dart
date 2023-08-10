import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'avatar.dart';
import 'channels_view.dart';
import 'chat_widget.dart';
import 'display_toast.dart';
import 'model.dart';
import 'profile_form.dart';
import 'providers.dart';
import 'realm_ui/realm_connectivity_indicator.dart';
import 'realm_ui/realm_search_delegate.dart';
import 'repository.dart';
import 'settings.dart';
import 'split_view.dart';
import 'tiles.dart';
import 'widget_builders.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedChannel = ref.watch(focusedChannelProvider);
    final repository = ref.watch(repositoryProvider);
    final twoPane = MediaQuery.of(context).size.width > 700;
    const menuWidth = 300.0;
    return repository.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (repository) {
        final user = repository.userProfile;
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${currentWorkspace?.name} / ${focusedChannel?.name ?? ''}'),
            actions: [
              RealmConnectivityIndicator(
                changes: repository.connectionStateChanges,
              ),
              IconButton(
                onPressed: () => showSearch(
                    context: context,
                    delegate: RealmSearchDelegate(
                      repository.searchMessage,
                      (context, item, animation) =>
                          MessageTile(message: item, animation: animation),
                    )),
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileForm(initialProfile: user)),
                  );
                },
                icon: MyAvatar(user: user),
              ),
            ],
          ),
          body: DisplayToast(
            stream: repository.x,
            builder: (message, animation) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    child: Text('in channel "${message.channel!.name}"'),
                  ),
                  MessageTile(message: message, animation: animation),
                ],
              );
            },
            child: SplitView(
              showLeft: twoPane,
              leftWidth: menuWidth,
              rightPane: _buildChatPane(focusedChannel, repository),
              leftPane: _buildChannelPane(ref, context),
            ),
          ),
          drawer: twoPane
              ? null // no drawer on large screens
              : Drawer(child: Builder(builder: (context) {
                  return _buildChannelPane(ref, context);
                })),
        );
      },
    );
  }

  Widget _buildChannelPane(WidgetRef ref, BuildContext context) {
    return SafeArea(
      child: ChannelsView(
        onTap: (channel) {
          ref.read(focusedChannelProvider.notifier).focus(channel);
          Scaffold.of(context).closeDrawer();
        },
      ),
    );
  }

  Widget _buildChatPane(Channel? focusedChannel, Repository repository) {
    return const Center(child: Text('Choose a channel'))
        .animate(target: focusedChannel == null ? 0 : 1)
        .crossfade(builder: (context) => const ChatWidget());
  }
}
