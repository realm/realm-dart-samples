import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kilochat/debug_widget.dart';
import 'package:kilochat/widget_builders.dart';
import 'package:statsfl/statsfl.dart';

import 'avatar.dart';
import 'firebase_options.dart';
import 'model.dart';
import 'profile_form.dart';
import 'providers.dart';
import 'realm_ui.dart';
import 'tiles.dart';

const freedomBlue = Color(0xff0057b7);
const energizingYellow = Color(0xffffd700);

enum Routes {
  logIn,
  chat;

  String get path => '/$this';
}

extension RoutesX on Routes {
  go(BuildContext context) => context.go(path);
}

final _router = GoRouter(
  initialLocation: Routes.logIn.path,
  routes: [
    GoRoute(
      path: Routes.chat.path,
      builder: (context, state) => const MyApp(),
    ),
    GoRoute(
      path: Routes.logIn.path,
      builder: (context, state) {
        return SignInScreen(actions: [
          AuthStateChangeAction<SignedIn>((context, state) async {
            final ref = ProviderScope.containerOf(context);
            final firebaseUserController =
                ref.read(firebaseUserProvider.notifier);
            firebaseUserController.state = state.user;
            Routes.chat.go(context);
          }),
        ]);
      },
    ),
  ],
);

Future<void> main() async {
  Animate.restartOnHotReload = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    AppleProvider(),
    FacebookProvider(clientId: ''),
    GoogleProvider(clientId: ''),
  ]);
  runApp(
    StatsFl(
      maxFps: 60,
      showText: false,
      child: ProviderScope(
        child: Builder(
          builder: (context) {
            final ref = ProviderScope.containerOf(context);
            return MaterialApp.router(
              routerConfig: _router,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: freedomBlue,
                  inversePrimary: energizingYellow,
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
            title: focusedChannel == null
                ? const Text('Kilochat')
                : Text('# ${focusedChannel.name}'),
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
              .crossfade(builder: (context) => const ChatWidget()),
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

class MessagesView extends ConsumerWidget {
  const MessagesView({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(focusedChannelProvider);
    final messages = ref.watch(messagesProvider(channel));
    return messages.when(
      error: buildErrorWidget,
      loading: buildLoadingWidget,
      data: (messages) => RealmAnimatedList(
        results: messages,
        itemBuilder: (context, item, animation) {
          return MessageTile(message: item, animation: animation);
        },
        reverse: true,
        controller: scrollController,
      ),
    );
  }
}

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
            //dense: true,
            selectedTileColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: Column(
            children: [
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
              Row(
                children: [
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
                  )
                ],
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
