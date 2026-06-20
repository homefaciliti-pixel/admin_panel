class ProfileModel {
  final String name;
  final String email;
  final String role;
  final String company;
  final String image;

  final int totalAdmins;
  final String revenue;

  ProfileModel({
    required this.name,
    required this.email,
    required this.role,
    required this.company,
    required this.image,
    required this.totalAdmins,
    required this.revenue,
  });
}