
import 'package:flutter/material.dart';

import '../../../notifiers/button_status_notifier.dart';

class RIcon extends StatefulWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final TextStyle? style;
  final ProcessStatusNotifier processStatusNotifier;
  final Color? iconColor;
  final Widget iconWidget;
  final Widget? disableStateWidget;
  final Widget? loadingStateWidget;
  final Widget? errorStateWidget;
  final Widget? doneStateWidget;
  final VoidCallback? onDone;
  const RIcon({
    required super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.style,
    this.iconColor,
    required this.iconWidget,
    this.disableStateWidget,
    this.loadingStateWidget,
    this.errorStateWidget,
    this.doneStateWidget,
    required this.processStatusNotifier,
    this.onDone,
  });

  @override
  State<RIcon> createState() => _RIconState();
}

class _RIconState extends State<RIcon> {

  _listenUpdate() {
    if(widget.processStatusNotifier.status == SuccessStatus()){
      if(widget.onDone != null) widget.onDone!();
    }
  }

  @override
  void initState() {
    super.initState();
    widget.processStatusNotifier.addListener(_listenUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    widget.processStatusNotifier.removeListener(_listenUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListenableBuilder(
          listenable: widget.processStatusNotifier,
          builder: (context, before) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: Builder(
                builder: (context) {
                  return switch (widget.processStatusNotifier.status) {
                    EnabledStatus _ => widget.iconWidget,
                    DisabledStatus _ => widget.disableStateWidget ?? Icon(Icons.block, color: widget.iconColor),
                    LoadingStatus _ => widget.loadingStateWidget ?? Icon(Icons.hourglass_empty, color: widget.iconColor),
                    ErrorStatus _ => widget.errorStateWidget ?? Icon(Icons.error, color: widget.iconColor),
                    SuccessStatus _ => widget.doneStateWidget ?? Icon(Icons.check, color: widget.iconColor),
                  };
                },
              )
            );
          }
        );
      },
    );
  }

}
