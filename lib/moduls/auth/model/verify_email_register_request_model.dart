class VerifyEmailRegisterRequestModel {
  final String email;
  final String otp;

  VerifyEmailRegisterRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }

  factory VerifyEmailRegisterRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VerifyEmailRegisterRequestModel(
      email: json['email'],
      otp: json['otp'],
    );
  }
}
