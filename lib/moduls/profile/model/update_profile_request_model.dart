class UpdateProfileRequestModel {
  final String name;
  final String phone;
  final String dob;
  final String? avatarPath;

  UpdateProfileRequestModel({
    required this.name,
    required this.phone,
    required this.dob,
    this.avatarPath,
  });

  Map<String, dynamic> toJson() {
    final payload = <String, dynamic>{
      'name': name,
      'phone': phone,
      'dob': dob,
    };
    if (avatarPath != null && avatarPath!.isNotEmpty) {
      payload['avatar'] = avatarPath;
    }
    return payload;
  }
}
