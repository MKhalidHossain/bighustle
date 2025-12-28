import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../services/debug/debug_service.dart';
import '../../../services/image_cache/image_service.dart';
import '../circle_shape.dart';

enum _Shape{
  circle,
  none,
}

class SmartNetworkImage extends StatefulWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double height;
  final double width;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool keepAlive;
  final _Shape shape;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;


  const SmartNetworkImage._({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    required this.height,
    required this.width,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.keepAlive = false,
    super.key,
    this.shape = _Shape.none,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth
  });

  const SmartNetworkImage({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    required this.height,
    required this.width,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.keepAlive = false,
    super.key,
  }): shape = _Shape.none,
      backgroundColor = null,
      borderColor = null,
      borderWidth = null;

  factory SmartNetworkImage.circle({
    Key? key,
    String? imageUrl,
    BoxFit fit = BoxFit.cover,
    double diameter = 50,
    BorderRadius? borderRadius,
    Widget? placeholder,
    Widget? errorWidget,
    bool keepAlive = false,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
  }) => SmartNetworkImage._(
    key: key,
    imageUrl: imageUrl,
    fit: fit,
    height: diameter,
    width: diameter,
    borderRadius: borderRadius ?? BorderRadius.circular(diameter),
    placeholder: placeholder,
    errorWidget: errorWidget,
    keepAlive: keepAlive,
    shape: _Shape.circle,
    backgroundColor: backgroundColor,
    borderColor: borderColor,
    borderWidth: borderWidth
  );


  @override
  State<SmartNetworkImage> createState() => _SmartNetworkImageState();
}

class _SmartNetworkImageState extends State<SmartNetworkImage> with AutomaticKeepAliveClientMixin{
  Uint8List? _imageBytes;
  bool _hasError = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _loadImage();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if(widget.imageUrl == null) {
      _hasError = true;
      setState(() {
        
      });
      return;
    }

    UIDebugger().dekhao("fetching image for url: ${widget.imageUrl}");
    final bytes = await ImageService().fetchImage(widget.imageUrl!);
    if (mounted) {
      setState(() {
        if (bytes != null) {
          _imageBytes = bytes;
        } else {
          _hasError = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_imageBytes != null) {
      // For Circle
      if(widget.shape == _Shape.circle) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.backgroundColor,
            border: Border.all(color: widget.borderColor ?? Colors.transparent, width: widget.borderWidth ?? 0)
          ),
          child: Image.memory(
            _imageBytes!,
            fit: widget.fit,
            height: widget.height,
            width: widget.width,
          ),
        );
      }
      // For other
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: Image.memory(
          _imageBytes!,
          fit: widget.fit,
          height: widget.height,
          width: widget.width,
        ),
      );
    } else if (_hasError) {
      return widget.errorWidget ?? const Icon(Icons.broken_image);
    } else {
      return widget.placeholder ??
          SizedBox(
            height: widget.height,
            width: widget.width,
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
    }
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => widget.keepAlive;
}
