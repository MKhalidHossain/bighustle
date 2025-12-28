class LogoutRequestModel {
  final String refreshToken;

  LogoutRequestModel({required this.refreshToken});

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
    };
  }

  LogoutRequestModel.fromJson(Map<String, dynamic> json)
      : refreshToken = json['refreshToken'];
}
