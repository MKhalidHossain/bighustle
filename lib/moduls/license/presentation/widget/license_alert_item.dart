import 'package:flutter/material.dart';

import '../../model/license_alert_model.dart';

class LicenseAlertItem extends StatelessWidget {
  final LicenseAlertModel alert;
  final bool showDivider;

  const LicenseAlertItem({
    super.key,
    required this.alert,
    this.showDivider = true,
  });

  Color _getSeverityColor() {
    switch (alert.severity.toLowerCase()) {
      case 'error':
      case 'danger':
        return Colors.red;
      case 'warning':
        return const Color(0xFFFFC107);
      case 'success':
        return Colors.green;
      case 'info':
      default:
        return const Color(0xFF2196F3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: _getSeverityColor(),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (alert.title.isNotEmpty)
                    Text(
                      alert.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if (alert.title.isNotEmpty && alert.message.isNotEmpty)
                    const SizedBox(height: 4),
                  if (alert.message.isNotEmpty)
                    Text(
                      alert.message,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFE6E6E6)),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
