import 'package:flutter/material.dart';
import '../../../core/constants/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------- HEADER ----------------
              Row(
                children: [
                  Text(
                    'Logo',
                    style: TextStyle(
                      color: const Color(0xFF3F76F6),
                      fontWeight: FontWeight.w700,
                      fontSize: (size.width * 0.03).clamp(18.0, 28.0),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: (size.width * 0.07).clamp(20.0, 28.0),
                        ),
                        const Positioned(
                          right: 4,
                          top: 4,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xFFE65151),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                    child: CircleAvatar(
                      radius: (size.width * 0.045).clamp(14.0, 20.0),
                      backgroundColor: const Color(0xFFE0E0E0),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              /// ---------------- GREETING ----------------
              Text(
                'Good Morning, John! 👋',
                style: TextStyle(
                  fontSize: (size.width * 0.02).clamp(18.0, 26.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Here's your dashboard",
                style: TextStyle(
                  fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  color: const Color(0xFF444444),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              /// ---------------- STATUS CARDS ----------------
              _StatusCard(
                size: size,
                title: 'Licence Status',
                value: 'Active',
                valueColor: const Color(0xFF1B8E3E),
                icon: Icon(
                  Icons.shield_outlined,
                  color: const Color(0xFF1B8E3E),
                  size: size.width * 0.08,
                ),
                iconBackground: const Color(0xFFE8F7ED),
              ),

              SizedBox(height: size.height * 0.015),

              _StatusCard(
                size: size,
                title: 'Licence Alerts',
                value: '2',
                valueColor: const Color(0xFFD64545),
                icon: Icon(
                  Icons.warning_amber_rounded,
                  color: const Color(0xFFD64545),
                  size: size.width * 0.08,
                ),
                iconBackground: const Color(0xFFFBEFE8),
              ),

              SizedBox(height: size.height * 0.015),

              /// IMAGE USED HERE ✅
              _StatusCard(
                size: size,
                title: 'Open Tickets',
                value: '1',
                valueColor: const Color(0xFF5C6BF2),
                icon: Image.asset(
                  'assets/images/mynaui_shield.png',
                  width: size.width * 0.09,
                  height: size.width * 0.09,
                  color: const Color(0xFF5C6BF2),
                ),
                iconBackground: const Color(0xFFEFF2FF),
              ),

              SizedBox(height: size.height * 0.03),

              /// ---------------- QUICK ACCESS ----------------
              Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: (size.width * 0.055).clamp(16.0, 22.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.02),

              Wrap(
                spacing: size.width * 0.04,
                runSpacing: size.height * 0.02,
                children: [
                  _QuickAccessCard(
                    size: size,
                    label: 'Licence Status',
                    icon: Icon(
                      Icons.shield_outlined,
                      size: size.width * 0.07,
                      color: const Color(0xFF1B8E3E),
                    ),
                    iconBackground: const Color(0xFFE8F7ED),
                    onTap: () => _showMessage(context, 'Licence Status'),
                  ),

                  _QuickAccessCard(
                    size: size,
                    label: 'Ticket Assistance',
                    icon: Image.asset(
                      'assets/images/mynaui_shield.png',
                      width: size.width * 0.09,
                      height: size.width * 0.09,
                      color: const Color(0xFF5C6BF2),
                    ),
                    iconBackground: const Color(0xFFEFF2FF),
                    onTap: () => _showMessage(context, 'Ticket Assistance'),
                  ),

                  _QuickAccessCard(
                    size: size,
                    label: 'Community',
                    icon: Icon(
                      Icons.group_outlined,
                      size: size.width * 0.07,
                      color: const Color(0xFFC08A0A),
                    ),
                    iconBackground: const Color(0xFFFFF4DB),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.teenDriverPosts);
                    },
                  ),

                  _QuickAccessCard(
                    size: size,
                    label: 'Teen Drivers',
                    icon: Icon(
                      Icons.school_outlined,
                      size: size.width * 0.07,
                      color: const Color(0xFFB54A4A),
                    ),
                    iconBackground: const Color(0xFFFCEAEA),
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.teenDrivers);
                    },
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              /// ---------------- RECENT ACTIVITY ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: (size.width * 0.055).clamp(16.0, 22.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRoutes.teenDrivers);
                    },
                    child: Text(
                      'See more',
                      style: TextStyle(
                        fontSize: (size.width * 0.042).clamp(12.0, 16.0),
                        color: const Color(0xFF3F76F6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),

              _ActivityTile(
                size: size,
                title: 'License verification completed',
                subtitle: '2 hours ago',
                icon: Icons.check_circle_outline,
                iconColor: const Color(0xFF1B8E3E),
                iconBackground: const Color(0xFFE8F7ED),
              ),
              SizedBox(height: size.height * 0.015),
              _ActivityTile(
                size: size,
                title: 'Ticket assistance request submitted',
                subtitle: '2 hours ago',
                icon: Icons.access_time,
                iconColor: const Color(0xFF3F76F6),
                iconBackground: const Color(0xFFEFF2FF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= STATUS CARD =================
class _StatusCard extends StatelessWidget {
  final Size size;
  final String title;
  final String value;
  final Color valueColor;
  final Widget icon;
  final Color iconBackground;

  const _StatusCard({
    required this.size,
    required this.title,
    required this.value,
    required this.valueColor,
    required this.icon,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: (size.width * 0.065).clamp(20.0, 30.0),
                    fontWeight: FontWeight.w700,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width * 0.16,
            height: size.width * 0.16,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Center(child: icon),
          ),
        ],
      ),
    );
  }
}

/// ================= QUICK ACCESS CARD =================
class _QuickAccessCard extends StatelessWidget {
  final Size size;
  final String label;
  final Widget icon;
  final Color iconBackground;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.size,
    required this.label,
    required this.icon,
    required this.iconBackground,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = (size.width - size.width * 0.16) / 2;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.025,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Container(
              width: size.width * 0.14,
              height: size.width * 0.14,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              child: Center(child: icon),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: (size.width * 0.042).clamp(12.0, 16.0),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= ACTIVITY TILE =================
class _ActivityTile extends StatelessWidget {
  final Size size;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;

  const _ActivityTile({
    required this.size,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.018,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.14,
            height: size.width * 0.14,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: size.width * 0.07),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: (size.width * 0.045).clamp(14.0, 18.0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.006),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: (size.width * 0.038).clamp(12.0, 16.0),
                    color: const Color(0xFF777777),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
