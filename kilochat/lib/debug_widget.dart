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
    debugPrint('$T@$hashCode initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DebugWidget<T> oldWidget) {
    debugPrint('$T@$hashCode didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    debugPrint('$T@$hashCode dispose');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    debugPrint('$T@$hashCode didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
