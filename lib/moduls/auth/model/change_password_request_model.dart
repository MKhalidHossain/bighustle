class ChangePasswordRequestModel {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequestModel(
      oldPassword: json['oldPassword'],
      newPassword: json['newPassword'],
    );
  }
}
