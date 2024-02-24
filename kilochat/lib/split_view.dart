import 'package:flutter/material.dart';

class SplitView extends StatelessWidget {
  final bool showLeft;
  final double leftWidth;
  final Widget leftPane;
  final Widget rightPane;

  const SplitView({
    super.key,
    required this.showLeft,
    required this.leftWidth,
    required this.leftPane,
    required this.rightPane,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.black, width: 0.5),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          width: showLeft ? leftWidth : 0,
          duration: const Duration(milliseconds: 300),
          child: OverflowBox(
            alignment: Alignment.centerRight,
            minWidth: leftWidth,
            maxWidth: leftWidth,
            child: leftPane,
          ),
        ),
        Expanded(
          child: ClipRect(
            child: rightPane,
          ),
        ),
      ],
    );
  }
}
