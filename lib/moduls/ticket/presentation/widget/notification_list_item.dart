import 'package:flutter/material.dart';

class NotificationListItem extends StatelessWidget {
  final String message;
  final String time;
  final bool isHighlighted;

  const NotificationListItem({
    super.key,
    required this.message,
    required this.time,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFFEAF5FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFDDE3EE),
            child: const Icon(Icons.person, size: 18, color: Color(0xFF5A6472)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E8E)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
