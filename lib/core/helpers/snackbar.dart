import 'package:flutter/material.dart';

sealed class SnackBarEntity {
  final Color color;
  final String message;
  final BuildContext context;

  SnackBarEntity({
    this.color = const Color(0xFFBA68C8),
    required this.message,
    required this.context,
  });
}

class ErrSnackBarEntity extends SnackBarEntity {
  ErrSnackBarEntity({
    required super.message,
    required super.context,
    super.color = const Color(0xFFF44336),
  });
}

class SuccessSnackBarEntity extends SnackBarEntity {
  SuccessSnackBarEntity({
    required super.message,
    required super.context,
    super.color = const Color(0xFF4CAF50),
  });
}
