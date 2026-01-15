class ForgetPasswordRequestModel {
  final String email;

  ForgetPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  // Convert a Map to a ForgetPasswordRequestModel object
  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRequestModel(
      email: json['email'],
    );
  }
}
