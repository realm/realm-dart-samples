import 'package:flutter/widgets.dart';

class DebugWidget<T extends Widget> extends StatefulWidget {
  final T child;

  const DebugWidget({super.key, required this.child});

  @override
  State<DebugWidget> createState() => _DebugWidgetState<T>();
}

class _DebugWidgetState<T extends Widget> extends State<DebugWidget<T>> {
  @override
  void initState() {
    print('$T@$hashCode initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DebugWidget<T> oldWidget) {
    print('$T@$hashCode didUpdateWidget'); // TODO: remove
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('$T@$hashCode dispose'); // TODO: remove
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print('$T@$hashCode didChangeDependencies'); // TODO: remove
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
