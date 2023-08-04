import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kilochat/channels_view.dart';
import 'package:kilochat/display_toast.dart';

import 'avatar.dart';
import 'chat_widget.dart';
import 'profile_form.dart';
import 'providers.dart';
import 'realm_ui.dart';
import 'settings.dart';
import 'tiles.dart';
import 'widget_builders.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedChannel = ref.watch(focusedChannelProvider);
    final repository = ref.watch(repositoryProvider);
    return repository.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (repository) {
        final user = repository.user;
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${currentWorkspace?.name} / ${focusedChannel?.name ?? ''}'),
            actions: [
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileForm(initialProfile: user)));
                },
                icon: MyAvatar(user: user),
              ),
            ],
          ),
          body: const Center(child: Text('Choose a channel'))
              .animate(target: focusedChannel == null ? 0 : 1)
              .crossfade(builder: (context) {
            return DisplayToast(
              stream: repository.x,
              builder: (message, animation) => //
                  //Text(message.text),
                  Column(
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
              ),
              child: const ChatWidget(),
            );
          }),
          drawer: Builder(
            builder: (context) {
              return Drawer(
                child: SafeArea(
                  child: ChannelsView(
                    onTap: (channel) {
                      ref.read(focusedChannelProvider.notifier).focus(channel);
                      Scaffold.of(context).closeDrawer();
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
