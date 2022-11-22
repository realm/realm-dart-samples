import 'dart:async';
import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:realm_dart/realm.dart';

import 'providers.dart';

const animationDuration = Duration(milliseconds: 100);

class NowTile extends StatelessWidget {
  final Now now;
  final void Function(DismissDirection)? onDismissed;
  final void Function()? onTap;
  final Animation<double> animation;

  const NowTile({
    Key? key,
    required this.now,
    required this.animation,
    this.onDismissed,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = this.key ?? ValueKey(now.id);
    return Dismissible(
      key: key,
      background: Container(
        alignment: AlignmentDirectional.centerStart,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      resizeDuration: null, // disable resize animation
      movementDuration: animationDuration,
      onDismissed: onDismissed,
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: AnimatedSwitcher(
            key: key,
            duration: animationDuration,
            child: Card(
              color: Color.alphaBlend(
                // blend with background color for more performant rendering
                now.category!.id.color.withOpacity(0.3),
                Theme.of(context).canvasColor,
              ),
              child: ListTile(
                onTap: onTap,
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.punch_clock),
                    Text(
                      now.time.formatted,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                title: Text(now.category?.name ?? 'n/a'),
                subtitle: Text(now.category?.parent?.fullName ?? ''),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (now.duration != null) ...[
                      Text(now.duration!.formattedShort, style: Theme.of(context).textTheme.labelSmall),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: now.category?.id == realm.latestEntry?.category?.id ? null : () => realm.write(() => now.resolveIn(realm)?.repeat()),
                        icon: const Icon(Icons.play_arrow),
                      ),
                    ] else
                      RefreshWidget(
                        duration: const Duration(seconds: 1),
                        builder: (_) {
                          return Text(
                            DateTime.now().difference(now.time).formattedShort,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              fontFeatures: [const FontFeature.tabularFigures()],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RefreshWidget extends StatefulWidget {
  final Duration duration;
  final WidgetBuilder builder;
  final Widget? child;

  const RefreshWidget({
    Key? key,
    required this.duration,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    // Don't user Timer.periodic because it may drift
    final durationInMs = widget.duration.inMilliseconds;
    final now = DateTime.now();
    var next = durationInMs - now.millisecond % durationInMs;
    timer = Timer(Duration(milliseconds: next), () {
      setState(() {});
      _next();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

extension on ObjectId {
  Color get color {
    // Construct a color directly from an integer value,
    // yields different results across platforms, so we
    // use explicit channels instead.
    final r = bytes[0];
    final g = bytes[1];
    final b = bytes[2];
    return Color.fromRGBO(r, g, b, 0);
  }
}
