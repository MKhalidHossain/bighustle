import 'package:flutter/material.dart';

class CircleShape extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  const CircleShape({super.key, required this.child, this.backgroundColor, this.borderColor, this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor ?? Colors.transparent, width: borderWidth ?? 0)
      ),
      child: child,
    );
  }
}