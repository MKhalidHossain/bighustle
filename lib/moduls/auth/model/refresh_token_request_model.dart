class RefreshTokenRequestModel {
  final String refreshToken;

  RefreshTokenRequestModel({required this.refreshToken});

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
    };
  }

  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRequestModel(
      refreshToken: json['refreshToken'],
    );
  }
}
