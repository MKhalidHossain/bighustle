import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../widget/ticket_card.dart';
import '../widget/ticket_summary_card.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            const SizedBox(height: 6),
            const Center(
              child: Text(
                'Ticket',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 18),
            const TicketSummaryCard(
              openTickets: 1,
              totalDue: r'$250.00',
              overdue: 0,
            ),
            const SizedBox(height: 16),
            const Text(
              'Active',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            TicketCard(
              ticketId: 'Ticket #TK-452566',
              type: 'Speeding',
              amount: r'$250.00',
              dueDate: 'Nov 25,2025',
              onPayNow: () => Navigator.of(context).pushNamed(
                AppRoutes.planPricing,
              ),
              onViewDetails: () => Navigator.of(context).pushNamed(
                AppRoutes.ticketDetails,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Paid',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            TicketCard(
              ticketId: 'Ticket #TK-452566',
              type: 'Speeding',
              amount: r'$250.00',
              dueDate: 'Nov 25,2025',
              isPaid: true,
              onViewDetails: () => Navigator.of(context).pushNamed(
                AppRoutes.ticketDetails,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
