class LicenseAlertModel {
  final String id;
  final String userId;
  final String type;
  final String title;
  final String message;
  final String severity;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  LicenseAlertModel({
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

  factory LicenseAlertModel.fromJson(Map<String, dynamic> json) {
    return LicenseAlertModel(
      id: json['_id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      severity: json['severity']?.toString() ?? 'info',
      isRead: json['isRead'] == true,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
    );
  }
}