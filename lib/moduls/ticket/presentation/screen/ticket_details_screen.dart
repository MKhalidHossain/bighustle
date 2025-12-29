import 'package:flutter/material.dart';

import '../../../../core/constants/app_routes.dart';
import '../widget/ticket_action_button.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.black87),
        title: const Text(
          'Ticket Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF4C8DFF), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF2F7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.confirmation_number_outlined, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Ticket #TK-452566',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Status', style: TextStyle(color: Color(0xFF6C6C6C))),
                  const SizedBox(width: 12),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE05A5A),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Unpaid',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Amount: \$250.00',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),
              const Text(
                'Important Dates',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const _DetailLine(label: 'Issued:', value: 'Nov 1, 2025'),
              const SizedBox(height: 6),
              const _DetailLine(label: 'Due:', value: 'Nov 25, 2025'),
              const SizedBox(height: 6),
              const _DetailLine(label: 'Days Left:', value: '7 days'),
              const SizedBox(height: 12),
              const Text(
                'Violation Details',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const _DetailLine(label: 'Type:', value: 'Speeding'),
              const SizedBox(height: 6),
              const _DetailLine(label: 'Speed:', value: '112 in lane 2'),
              const SizedBox(height: 6),
              const _DetailLine(label: 'Location:', value: 'Highway 192'),
              const SizedBox(height: 6),
              const _DetailLine(label: 'Officer:', value: 'Badge #2345'),
              const SizedBox(height: 12),
              const Text(
                'Warnings',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const _DetailLine(label: 'May cause', value: 'suspension'),
              const SizedBox(height: 6),
              const _DetailLine(label: 'Late fees', value: 'apply after due'),
              const SizedBox(height: 6),
              const _DetailLine(label: 'Point on license:', value: '2'),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TicketActionButton(
                  label: 'Pay now',
                  onPressed: () => Navigator.of(context).pushNamed(
                    AppRoutes.planPricing,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLine({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF6C6C6C)),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
