import '../../license/model/license_response_model.dart';

class HomeResponseModel {
  final LicenseResponseModel? licenseState;
  final int ticketAlerts;
  final List<HomeActivityModel> recentActivity;

  HomeResponseModel({
    required this.licenseState,
    required this.ticketAlerts,
    required this.recentActivity,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    final licenseRaw = json['licenseSate'] ?? json['licenseState'];
    LicenseResponseModel? license;
    if (licenseRaw is Map) {
      license = LicenseResponseModel.fromJson(
        Map<String, dynamic>.from(licenseRaw),
      );
    }

    final activityRaw = json['recentActivity'];
    final activities = <HomeActivityModel>[];
    if (activityRaw is List) {
      for (final item in activityRaw) {
        if (item is Map) {
          activities.add(
            HomeActivityModel.fromJson(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    return HomeResponseModel(
      licenseState: license,
      ticketAlerts: _readInt(json['ticketAlerts']),
      recentActivity: activities,
    );
  }

  factory HomeResponseModel.empty() {
    return HomeResponseModel(
      licenseState: null,
      ticketAlerts: 0,
      recentActivity: const [],
    );
  }

  static int _readInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    if (value is String) return int.tryParse(value.trim()) ?? 0;
    return 0;
  }
}

class HomeActivityModel {
  final String id;
  final String userId;
  final String type;
  final String title;
  final String message;
  final String severity;
  final bool isRead;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HomeActivityModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    required this.severity,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeActivityModel.fromJson(Map<String, dynamic> json) {
    return HomeActivityModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      severity: json['severity']?.toString() ?? '',
      isRead: _readBool(json['isRead']),
      createdAt: _readDate(json['createdAt']),
      updatedAt: _readDate(json['updatedAt']),
    );
  }

  static bool _readBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      return normalized == 'true' ||
          normalized == '1' ||
          normalized == 'yes';
    }
    return false;
  }

  static DateTime? _readDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}
