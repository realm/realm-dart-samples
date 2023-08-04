import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'messages_view.dart';
import 'providers.dart';

class ChatWidget extends ConsumerStatefulWidget {
  const ChatWidget({super.key});

  @override
  ConsumerState<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends ConsumerState<ChatWidget> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: MessagesView(scrollController: scrollController)),
        Ink(
          color: Theme.of(context).colorScheme.inversePrimary,
          padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: TextField(
                    minLines: 1,
                    maxLines: 5,
                    controller: controller,
                    decoration: const InputDecoration(
                      label: Text('Enter next message'),
                      border: InputBorder.none,
                      hintText: 'here..',
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: _postNewMessage,
                  ),
                ),
              ),
              IconButton(
                enableFeedback: true,
                onPressed: () => _postNewMessage(controller.text),
                icon: const Icon(Icons.send),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _postNewMessage(String text) async {
    if (text.isNotEmpty) {
      final channel = ref.read(focusedChannelProvider);
      final repository = ref.read(repositoryProvider).requireValue;
      repository.postNewMessage(channel!, text);
      controller.clear();
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
