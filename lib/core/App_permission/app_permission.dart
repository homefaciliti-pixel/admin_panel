class AppPermission {
  static String role = "";

  static bool get isSuperAdmin => role == "super_admin";

  static bool get isAdmin => role == "admin";
}
