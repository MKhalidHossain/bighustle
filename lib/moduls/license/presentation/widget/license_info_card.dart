import 'package:flutter/material.dart';

import 'license_info_row.dart';

class LicenseInfoCard extends StatelessWidget {
  final String name;
  final String licenseNo;
  final String state;
  final String dateOfBirth;
  final String expireDate;
  final bool isEditableStyle;

  const LicenseInfoCard({
    super.key,
    required this.name,
    required this.licenseNo,
    required this.state,
    required this.dateOfBirth,
    required this.expireDate,
    this.isEditableStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        border: isEditableStyle
            ? Border.all(color: const Color(0xFF2F2F2F), width: 0.8)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'License Information',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          LicenseInfoRow(label: 'Name', value: name),
          LicenseInfoRow(label: 'License No', value: licenseNo),
          LicenseInfoRow(label: 'State', value: state),
          LicenseInfoRow(label: 'Date of birth', value: dateOfBirth),
          LicenseInfoRow(
            label: 'Expire Date',
            value: expireDate,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
