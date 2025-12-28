import 'package:flutter/material.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 2,
          child: Text(
            'Status',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Ticket ID',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Fees',
            textAlign: TextAlign.end,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class TicketRow extends StatelessWidget {
  const TicketRow({
    super.key,
    required this.status,
    required this.statusColor,
  });

  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 3,
            child: Text('#TK-452566', style: TextStyle(fontSize: 12)),
          ),
          const Expanded(
            flex: 2,
            child: Text('Berlin', style: TextStyle(fontSize: 12)),
          ),
          const Expanded(
            flex: 2,
            child: Text(
              '\$250.00',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
