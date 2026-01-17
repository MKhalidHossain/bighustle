class VerifyEmailRequestModel {
  final String email;
  final String otp;
  final String purpose;

  VerifyEmailRequestModel({
    required this.email,
    required this.otp,
    required this.purpose,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
      'purpose': purpose,
    };
  }

  // Convert a Map to a VerifyEmailRequestModel object
  factory VerifyEmailRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyEmailRequestModel(
      email: json['email'],
      otp: json['otp'],
      purpose: json['purpose'],
    );
  }
}
