class RegisterRequest {
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
  };

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        email: json['email'] as String? ?? '',
        password: json['password'] as String? ?? '',
        confirmPassword: json['confirmPassword'] as String? ?? '',
      );

  RegisterRequest copyWith({
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  String toString() =>
      'RegisterRequest(email: $email, password: ****, confirmPassword: ****)';
}
