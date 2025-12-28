class VerifyEmailRequestModel {
  final String contact;
  final String otp;

  VerifyEmailRequestModel({required this.contact, required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'contact': contact,
      'otp': otp,
    };
  }

  // Convert a Map to a VerifyEmailRequestModel object
  factory VerifyEmailRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyEmailRequestModel(
      contact: json['contact'],
      otp: json['otp'],
    );
  }
}
