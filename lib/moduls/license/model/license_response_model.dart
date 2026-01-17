class LicenseResponseModel {
  final String id;
  final String userId;
  final String fullName;
  final String userPhoto;
  final String licenseNumber;
  final String state;
  final DateTime? dateOfBirth;
  final DateTime? expiryDate;
  final String licenseClass;
  final String licensePhoto;
  final String licenseStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  LicenseResponseModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.userPhoto,
    required this.licenseNumber,
    required this.state,
    this.dateOfBirth,
    this.expiryDate,
    required this.licenseClass,
    required this.licensePhoto,
    required this.licenseStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LicenseResponseModel.fromJson(Map<String, dynamic> json) {
    return LicenseResponseModel(
      id: json['_id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      userPhoto: json['userPhoto']?.toString() ?? '',
      licenseNumber: json['licenseNumber']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'].toString())
          : null,
      expiryDate: json['expirationDate'] != null
          ? DateTime.tryParse(json['expirationDate'].toString())
          : null,
      licenseClass: json['licenseClass']?.toString() ?? '',
      licensePhoto: json['licensePhoto']?.toString() ?? '',
      licenseStatus: json['licenseStatus']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
    );
  }




}
