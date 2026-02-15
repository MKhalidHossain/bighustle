import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/services/app_pigeon/app_pigeon.dart';
import '../../interface/license_interface.dart';
import '../../model/license_response_model.dart';

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
  final String userPhoto;
  final String licensePhoto;
  final String rawDateOfBirth; // ISO format for API
  final String rawExpireDate; // ISO format for API
  final String licenseClass; // For API

  const LicenseInfo({
    required this.status,
    required this.validity,
    required this.expiryShort,
    required this.name,
    required this.licenseNo,
    required this.state,
    required this.dateOfBirth,
    required this.expireDate,
    required this.userPhoto,
    required this.licensePhoto,
    required this.rawDateOfBirth,
    required this.rawExpireDate,
    required this.licenseClass,
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
    String? userPhoto,
    String? licensePhoto,
    String? rawDateOfBirth,
    String? rawExpireDate,
    String? licenseClass,
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
      userPhoto: userPhoto ?? this.userPhoto,
      licensePhoto: licensePhoto ?? this.licensePhoto,
      rawDateOfBirth: rawDateOfBirth ?? this.rawDateOfBirth,
      rawExpireDate: rawExpireDate ?? this.rawExpireDate,
      licenseClass: licenseClass ?? this.licenseClass,
    );
  }

  factory LicenseInfo.fromLicenseResponse(LicenseResponseModel response) {
    // Format status
    String status = response.licenseStatus.isEmpty
        ? 'Pending'
        : response.licenseStatus[0].toUpperCase() +
            response.licenseStatus.substring(1).toLowerCase();

    // Determine validity based on expiry date
    String validity = 'Valid';
    if (response.expiryDate != null) {
      final now = DateTime.now();
      if (response.expiryDate!.isBefore(now)) {
        validity = 'Expired';
      }
    }

    // Format expiry date short (MM/dd/yy)
    String expiryShort = 'N/A';
    if (response.expiryDate != null) {
      final month = response.expiryDate!.month.toString().padLeft(2, '0');
      final day = response.expiryDate!.day.toString().padLeft(2, '0');
      final year = response.expiryDate!.year.toString().substring(2);
      expiryShort = '$month/$day/$year';
    }

    // Format date of birth
    String dateOfBirthFormatted = 'N/A';
    if (response.dateOfBirth != null) {
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      final day = response.dateOfBirth!.day;
      final month = months[response.dateOfBirth!.month - 1];
      final year = response.dateOfBirth!.year;
      dateOfBirthFormatted = '$day${_getDaySuffix(day)} $month, $year';
    }

    // Format expire date
    String expireDateFormatted = 'N/A';
    if (response.expiryDate != null) {
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      final day = response.expiryDate!.day;
      final month = months[response.expiryDate!.month - 1];
      final year = response.expiryDate!.year;
      expireDateFormatted = '$day${_getDaySuffix(day)} $month, $year';
    }

    // Get raw ISO date strings for API calls
    String rawDateOfBirth = '';
    if (response.dateOfBirth != null) {
      rawDateOfBirth = response.dateOfBirth!.toIso8601String();
    }
    
    String rawExpireDate = '';
    if (response.expiryDate != null) {
      rawExpireDate = response.expiryDate!.toIso8601String();
    }

    return LicenseInfo(
      status: status,
      validity: validity,
      expiryShort: expiryShort,
      name: response.fullName.isEmpty ? 'N/A' : response.fullName,
      licenseNo: response.licenseNumber,
      state: response.state,
      dateOfBirth: dateOfBirthFormatted,
      expireDate: expireDateFormatted,
      userPhoto: response.userPhoto,
      licensePhoto: response.licensePhoto,
      rawDateOfBirth: rawDateOfBirth,
      rawExpireDate: rawExpireDate,
      licenseClass: response.licenseClass,
    );
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

class LicenseInfoController {
  static final ValueNotifier<LicenseInfo> notifier = ValueNotifier(
    const LicenseInfo(
      status: 'Pending',
      validity: 'Valid',
      expiryShort: 'N/A',
      name: 'N/A',
      licenseNo: '',
      state: '',
      dateOfBirth: 'N/A',
      expireDate: 'N/A',
      userPhoto: '',
      licensePhoto: '',
      rawDateOfBirth: '',
      rawExpireDate: '',
      licenseClass: '',
    ),
  );

  static final ValueNotifier<bool> isLoading = ValueNotifier(false);
  static final ValueNotifier<bool> hasLoaded = ValueNotifier(false);

  static void update(LicenseInfo info) {
    notifier.value = info;
  }

  static bool _isValidUrl(String? url) {
    if (url == null) return false;
    final trimmedUrl = url.trim();
    if (trimmedUrl.isEmpty) return false;
    // Check if it's a valid URL format (starts with http:// or https://)
    return trimmedUrl.startsWith('http://') || trimmedUrl.startsWith('https://');
  }

  static Future<String> _getUserAvatarFromAuth() async {
    try {
      final appPigeon = Get.find<AppPigeon>();
      final authStatus = await appPigeon.currentAuth();
      if (authStatus is Authenticated) {
        final auth = authStatus.auth;
        final userData = auth.data['user'] as Map?;
        if (userData != null) {
          final avatar = userData['avatar'] as Map?;
          if (avatar != null) {
            final url = avatar['url'] as String?;
            if (_isValidUrl(url)) {
              return url!.trim();
            }
          }
        }
      }
    } catch (e) {
      // Silently fail if we can't get auth data
    }
    return '';
  }

  static Future<void> loadLicenseData({SnackbarNotifier? snackbarNotifier}) async {
    try {
      isLoading.value = true;
      
      final licenseInterface = Get.find<LicenseInterface>();
      final result = await licenseInterface.getLicense();

      result.fold(
        (failure) {
          snackbarNotifier?.notifyError(
            message: failure.uiMessage.isNotEmpty
                ? failure.uiMessage
                : 'Failed to load license information',
          );
          // Keep default values on error
        },
        (success) async {
          if (success.data != null && success.data!.isNotEmpty) {
            // Use the first license if multiple exist
            final licenseData = success.data!.first;
            var licenseInfo = LicenseInfo.fromLicenseResponse(licenseData);
            
            // If userPhoto is empty or invalid, try to get it from stored auth data
            if (!_isValidUrl(licenseInfo.userPhoto)) {
              final userAvatar = await _getUserAvatarFromAuth();
              if (_isValidUrl(userAvatar)) {
                licenseInfo = licenseInfo.copyWith(userPhoto: userAvatar);
              }
            }
            
            update(licenseInfo);
          } else {
            snackbarNotifier?.notifyError(
              message: 'No license data found',
            );
          }
        },
      );
    } catch (e) {
      snackbarNotifier?.notifyError(
        message: 'An error occurred while loading license data',
      );
    } finally {
      isLoading.value = false;
      hasLoaded.value = true;
    }
  }
}
