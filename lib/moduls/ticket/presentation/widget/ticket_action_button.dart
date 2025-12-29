import 'package:flutter/material.dart';

class TicketActionButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final bool isDisabled;
  final VoidCallback? onPressed;

  const TicketActionButton({
    super.key,
    required this.label,
    this.isPrimary = true,
    this.isDisabled = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color background = isDisabled
        ? const Color(0xFFE0E0E0)
        : isPrimary
            ? const Color(0xFF3F76F6)
            : Colors.white;
    final Color foreground = isDisabled
        ? const Color(0xFF9B9B9B)
        : isPrimary
            ? Colors.white
            : const Color(0xFF3F76F6);
    final BorderSide border = isPrimary
        ? BorderSide.none
        : BorderSide(
            color: isDisabled ? const Color(0xFFE0E0E0) : const Color(0xFF3F76F6),
          );

    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background,
          disabledForegroundColor: foreground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: border,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
