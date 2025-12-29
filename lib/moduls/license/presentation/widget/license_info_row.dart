import 'package:flutter/material.dart';

class LicenseInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool showDivider;

  const LicenseInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              value,
              style: const TextStyle(color: Color(0xFF6F6F6F)),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 8),
          const Divider(height: 1, color: Color(0xFFE4E4E4)),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
