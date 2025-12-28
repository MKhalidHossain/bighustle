import 'package:flutter/material.dart';

class RInkwellButton extends StatefulWidget {
  final Widget child;
  final Size? size;
  final Color? splashColor;

  /// Return false if operation is completed.
  final Function()? onTap;
  final BorderRadius? borderRadius;
  const RInkwellButton({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.size,
    this.splashColor,
  });

  @override
  State<RInkwellButton> createState() => _RInkwellButtonState();
}

class _RInkwellButtonState extends State<RInkwellButton> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        BorderRadius buttonBorderRadius =
            widget.borderRadius ?? BorderRadius.circular(10);
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: widget.splashColor,
            borderRadius: buttonBorderRadius,
            onTap: widget.onTap == null
                ? null
                : () async {
                    await Future.delayed(Duration(milliseconds: 500)).then((
                      _,
                    ) async {
                      if (context.mounted && mounted) {
                        widget.onTap!();
                      }
                    });
                  },

            child: widget.child,
          ),
        );
      },
    );
  }
}
