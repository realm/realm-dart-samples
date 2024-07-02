import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'avatar.dart';
import 'channels_view.dart';
import 'chat_widget.dart';
import 'display_toast.dart';
import 'profile_form.dart';
import 'providers.dart';
import 'realm_ui/realm_session_state_indicator.dart';
import 'realm_ui/realm_search_delegate.dart';
import 'repository.dart';
import 'settings.dart';
import 'split_view.dart';
import 'tiles.dart';
import 'widget_builders.dart';

final platformIsDesktop =
    Platform.isMacOS || Platform.isWindows || Platform.isLinux;

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(repositoryProvider);
    final focusedChannel = ref.watch(focusedChannelProvider).value;
    final twoPane = MediaQuery.of(context).size.width > 700;
    const menuWidth = 300.0;
    return repository.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (repository) {
        final user = repository.userProfile;
        return Scaffold(
          extendBodyBehindAppBar: platformIsDesktop,
          appBar: AppBar(
            title: Text(
                '${currentWorkspace?.name} / ${focusedChannel?.name ?? ''}'),
            actions: [
              RealmSessionStateIndicator(session: repository.session),
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
            stream: repository.notifications,
            builder: (message, animation) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    child: Text('in channel "${message.channel?.name ?? 'unknown'}"'),
                  ),
                  MessageTile(message: message, animation: animation),
                ],
              );
            },
            child: SplitView(
              showLeft: twoPane,
              leftWidth: menuWidth,
              rightPane: _buildChatPane(repository),
              leftPane: _buildChannelPane(repository, context),
            ),
          ),
          drawer: twoPane
              ? null // no drawer on large screens
              : Drawer(child: Builder(builder: (context) {
                  return _buildChannelPane(repository, context);
                })),
        );
      },
    );
  }

  Widget _buildChannelPane(Repository repository, BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return ChannelsView(
          onTap: (channel) {
            repository.focusedChannel = channel;
            Scaffold.of(context).closeDrawer();
          },
        );
      }),
    );
  }

  Widget _buildChatPane(Repository repository) {
    final channel = repository.focusedChannel;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: channel == null
          ? const Center(child: Text('Choose a channel'))
          : ChatWidget(key: ValueKey(channel.id)),
    );
  }
}