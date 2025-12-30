import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';
import '../controller/license_info_controller.dart';
import '../widget/license_alert_item.dart';
import '../widget/license_info_card.dart';
import '../widget/license_status_card.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'License',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.editLicenseInfo,
            ),
            icon: const Icon(Icons.edit_outlined, color: Colors.black87),
          ),
        ],
      ),
      body: ValueListenableBuilder<LicenseInfo>(
        valueListenable: LicenseInfoController.notifier,
        builder: (context, info, _) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              LicenseStatusCard(
                status: info.status,
                validity: info.validity,
                expiryDate: info.expiryShort,
              ),
              const SizedBox(height: 12),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/drivingLicence.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              LicenseInfoCard(
                name: info.name,
                licenseNo: info.licenseNo,
                state: info.state,
                dateOfBirth: info.dateOfBirth,
                expireDate: info.expireDate,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Alert & Information',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                            AppRoutes.licenseAlerts,
                          ),
                          child: const Text(
                            'View all',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const LicenseAlertItem(
                      message: 'Unpaid Ticket',
                      showDivider: true,
                    ),
                    const LicenseAlertItem(
                      message: 'Suspend..',
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
