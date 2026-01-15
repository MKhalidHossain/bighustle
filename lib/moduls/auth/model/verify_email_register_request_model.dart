class VerifyEmailRegisterRequestModel {
  final String email;
  final String otp;
  final String purpose;

  VerifyEmailRegisterRequestModel({
    required this.email,
    required this.otp,
    this.purpose = 'register',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
      'purpose': purpose,
    };
  }

  factory VerifyEmailRegisterRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VerifyEmailRegisterRequestModel(
      email: json['email'],
      otp: json['otp'],
      purpose: json['purpose'] as String? ?? 'register',
    );
  }
}
