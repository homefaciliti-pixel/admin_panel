// lib/core/app_permission.dart

class AppPermission {
  static String role = "super_admin";

  static bool get isSuperAdmin =>
      role == "super_admin";

  static bool get isAdmin =>
      role == "admin";
}