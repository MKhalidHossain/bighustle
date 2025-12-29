import 'package:flutter/foundation.dart';

@immutable
class LicenseInfo {
  final String status;
  final String validity;
  final String expiryShort;
  final String name;
  final String licenseNo;
  final String state;
  final String dateOfBirth;
  final String expireDate;

  const LicenseInfo({
    required this.status,
    required this.validity,
    required this.expiryShort,
    required this.name,
    required this.licenseNo,
    required this.state,
    required this.dateOfBirth,
    required this.expireDate,
  });

  LicenseInfo copyWith({
    String? status,
    String? validity,
    String? expiryShort,
    String? name,
    String? licenseNo,
    String? state,
    String? dateOfBirth,
    String? expireDate,
  }) {
    return LicenseInfo(
      status: status ?? this.status,
      validity: validity ?? this.validity,
      expiryShort: expiryShort ?? this.expiryShort,
      name: name ?? this.name,
      licenseNo: licenseNo ?? this.licenseNo,
      state: state ?? this.state,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      expireDate: expireDate ?? this.expireDate,
    );
  }
}

class LicenseInfoController {
  static final ValueNotifier<LicenseInfo> notifier = ValueNotifier(
    const LicenseInfo(
      status: 'Active',
      validity: 'Valid',
      expiryShort: '12/08/29',
      name: 'Joseph Junior',
      licenseNo: 'CS235613131656',
      state: 'Kingsland',
      dateOfBirth: '19th July, 1990',
      expireDate: '19th July, 2026',
    ),
  );

  static void update(LicenseInfo info) {
    notifier.value = info;
  }
}
