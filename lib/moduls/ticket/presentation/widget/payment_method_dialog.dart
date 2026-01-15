import 'package:flutter/material.dart';

import 'ticket_action_button.dart';

class PaymentMethodDialog extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onClose;
  final VoidCallback? onSelect;
  final VoidCallback? onPay;

  const PaymentMethodDialog({
    super.key,
    this.isSelected = true,
    this.onClose,
    this.onSelect,
    this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                const Text(
                  'Select Payment Method',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const Spacer(),
                InkWell(
                  onTap: onClose,
                  child: const Icon(Icons.close, size: 18, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 14),
            InkWell(
              onTap: onSelect,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE3E3E3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_rounded,
                        color: Color(0xFF3F76F6)),
                    const SizedBox(width: 8),
                    const Text(
                      'PayPal',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: const Color(0xFF3F76F6),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TicketActionButton(
                label: 'Pay Now',
                onPressed: onPay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
