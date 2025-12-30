import 'package:flutter/material.dart';

class PolicySection extends StatelessWidget {
  const PolicySection({
    super.key,
    required this.number,
    required this.title,
    required this.body,
  });

  final String number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black54, fontSize: 15),
          children: [
            TextSpan(
              text: '$number. $title\n',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            TextSpan(text: body),
          ],
        ),
      ),
    );
  }
}
