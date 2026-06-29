class AdminModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final String lastGeneratedAt;
  final String timeRemaining;

  AdminModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.lastGeneratedAt,
    required this.timeRemaining,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json["id"] ?? 0,
      email: json["email"] ?? "",
      username: json["username"] ?? "",
      password: json["password"] ?? "",
      lastGeneratedAt: json["lastGeneratedAt"] ?? "",
      timeRemaining: json["timeRemaining"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "username": username,
      "password": password,
      "lastGeneratedAt": lastGeneratedAt,
      "timeRemaining": timeRemaining,
    };
  }
}