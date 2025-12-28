class LoginRequestModel {
  final String emailOrId;
  final String password;

  LoginRequestModel({required this.emailOrId, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'emailOrId': emailOrId,
      'password': password,
    };
  }

  // Convert a Map to a LoginRequest object
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      emailOrId: json['emailOrId'],
      password: json['password'],
    );
  }
}
