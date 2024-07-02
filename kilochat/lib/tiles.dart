import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown/markdown.dart' as md;

import 'avatar.dart';
import 'model.dart';
import 'providers.dart';
import 'realm_ui/realm_animated_list.dart';

class ChannelTile extends StatelessWidget {
  final Channel channel;
  final Animation<double> animation;
  final void Function()? onTap;
  final void Function(DismissDirection)? onDismissed;
  final bool selected;

  const ChannelTile({
    super.key,
    required this.channel,
    required this.animation,
    this.onTap,
    this.onDismissed,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDismissibleTile(
      key: ValueKey(channel.id),
      animation: animation,
      title: Text('# ${channel.name}'),
      onTap: onTap,
      onDismissed: onDismissed,
      selected: selected,
    );
  }
}

class MessageTile extends ConsumerWidget {
  const MessageTile({
    super.key,
    required this.message,
    required this.animation,
  });

  final Message message;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(repositoryProvider).requireValue;
    final user = repo.userProfile;

    return AnimatedDismissibleTile(
      key: ValueKey(message.id),
      animation: animation,
      leading: MyAvatar(user: message.owner),
      title: Text(message.owner?.name ?? 'N/A ${message.ownerId}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTransition(
            animation: animation,
            child: MarkdownBody(
              //padding: const EdgeInsets.only(bottom: 12),
              data: message.text,
              //shrinkWrap: true,
              extensionSet: md.ExtensionSet(
                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                [
                  md.EmojiSyntax(),
                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32,
            child: RealmAnimatedList(
              results: message.reactions,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, reaction, animation) {
                final owner = reaction.owner?.id == user.id;
                return MyTransition(
                  key: ValueKey(reaction.id),
                  axis: Axis.horizontal,
                  animation: animation,
                  child: Chip(
                    visualDensity: VisualDensity.compact,
                    avatar: MyAvatar(user: reaction.owner),
                    label: AnimatedEmoji(
                      AnimatedEmojis.fromId(
                        reaction.emojiUnicode.toRadixString(16),
                      ),
                      repeat: false,
                      size: 16,
                      errorWidget: Text(reaction.emoji),
                    ),
                    onDeleted:
                        owner ? () => repo.deleteReaction(reaction) : null,
                  ),
                );
              },
            ),
          )
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          (ref.read(repositoryProvider.future)).then((repository) {
            repository.addReaction(message, '👍');
          });
        },
      ),
      onDismissed: message.ownerId != user.id
          ? null
          : (direction) async {
              (await ref.read(repositoryProvider.future))
                  .deleteMessage(message);
            },
    );
  }
}

class AnimatedDismissibleTile extends StatelessWidget {
  final Animation<double> animation;
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? subtitle;
  final bool selected;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function(DismissDirection direction)? onDismissed;

  const AnimatedDismissibleTile({
    required Key key,
    required this.animation,
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.onTap,
    this.onLongPress,
    this.onDismissed,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tile = MyTransition(
        key: key,
        animation: animation,
        child: ListTile(
          leading: leading,
          trailing: trailing,
          title: title,
          subtitle: subtitle,
          selected: selected,
          onTap: onTap,
          onLongPress: onLongPress,
        ));

    if (onDismissed == null) return tile;

    final colorScheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: key!,
      background: Container(color: colorScheme.onErrorContainer),
      onDismissed: onDismissed,
      resizeDuration: null,
      child: tile,
    );
  }
}

class MyTransition extends StatelessWidget {
  const MyTransition({
    super.key,
    required this.animation,
    required this.child,
    this.axis = Axis.vertical,
  });

  final Animation<double> animation;
  final Widget child;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        axis: axis,
        sizeFactor: animation,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: child,
        ),
      ),
    );
  }
}
