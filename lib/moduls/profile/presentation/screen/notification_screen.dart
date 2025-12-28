import 'package:flutter/material.dart';

import '../widget/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _ticketAlerts = true;
  bool _licenseAlerts = true;
  bool _inactiveAlerts = false;
  bool _teenDriverAlerts = false;
  bool _communityAlerts = false;

  static const Color _background = Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          NotificationTile(
            title: 'Tickets alerts',
            value: _ticketAlerts,
            onChanged: (value) => setState(() => _ticketAlerts = value),
          ),
          NotificationTile(
            title: 'License Expiry alerts',
            value: _licenseAlerts,
            onChanged: (value) => setState(() => _licenseAlerts = value),
          ),
          NotificationTile(
            title: 'Inactive alert',
            value: _inactiveAlerts,
            onChanged: (value) => setState(() => _inactiveAlerts = value),
          ),
          NotificationTile(
            title: 'Teen driver alerts',
            value: _teenDriverAlerts,
            onChanged: (value) => setState(() => _teenDriverAlerts = value),
          ),
          NotificationTile(
            title: 'Community alerts',
            value: _communityAlerts,
            onChanged: (value) => setState(() => _communityAlerts = value),
          ),
        ],
      ),
    );
  }
}
