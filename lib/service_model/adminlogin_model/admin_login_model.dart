class AdminLoginModel {
  final int id;
  final String email;
  final String username;
  final String role;

  AdminLoginModel({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
  });

  factory AdminLoginModel.fromJson(Map<String, dynamic> json) {
    return AdminLoginModel(
      id: json["id"] ?? 0,
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      role: json["role"] ?? "admin",
    );
  }
}