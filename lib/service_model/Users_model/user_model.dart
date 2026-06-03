class UserModel {
  /// User ID from backend
  final int id;

  /// User full name
  final String name;

  /// User email
  final String email;

  /// User mobile number
  final String mobile;

  /// User address
  final String address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
  });

  /// Convert backend JSON into model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
    );
  }
}