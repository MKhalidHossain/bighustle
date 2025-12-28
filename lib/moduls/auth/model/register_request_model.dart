class RegisterRequest {
  final String name;
  final String email;
  final String employeeId;
  final String password;
  final String role;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.employeeId,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'employeeId': employeeId,
    'password': password,
    'role': role,
  };

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        employeeId: json['employeeId'] as String? ?? '',
        password: json['password'] as String? ?? '',
        role: json['role'] as String? ?? '',
      );

  RegisterRequest copyWith({
    String? name,
    String? email,
    String? employeeId,
    String? password,
    String? role,
  }) {
    return RegisterRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      employeeId: employeeId ?? this.employeeId,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  @override
  String toString() =>
      'RegisterRequest(name: $name, email: $email, employeeId: $employeeId, password: ****, role: $role)';
}
