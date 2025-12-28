class ResetPasswordRequestModel {
  final String email;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequestModel({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }

  // Convert a Map to a ResetPasswordRequestModel object
  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequestModel(
      email: json['email'],
      newPassword: json['newPassword'],
      confirmPassword: json['confirmPassword'],
    );
  }
}
