import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/App_permission/app_permission.dart';
import '../../data/repositories/auth_repository.dart';
import '../../service_Api/adminAuth/admin_auth.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AdminAuth _adminAuth = AdminAuth();

  bool isLoading = false;
  bool obscurePassword = true;
  String? errorMessage;

  String selectedRole = "super_admin";

  void changeRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    AppPermission.role = "";

    notifyListeners();
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      /// SUPER ADMIN LOGIN (Static)
      if (selectedRole == "super_admin") {
        final result = await _authRepository.login(
          email: email,
          password: password,
        );

        if (result != null) {
          final prefs = await SharedPreferences.getInstance();

          await prefs.setBool("isLoggedIn", true);
          await prefs.setString("role", result["role"]!);
          await prefs.setString("name", result["name"]!);
          await prefs.setString("email", email);

          AppPermission.role = result["role"]!;

          return true;
        }

        errorMessage = "Invalid email or password";
        return false;
      }

      /// NORMAL ADMIN LOGIN (Backend)
      final admin = await _adminAuth.login(
        username: email,
        password: password,
      );

      if (admin != null) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("name", admin.username);
        await prefs.setString("username", admin.username);
        await prefs.setString("email", admin.email);
        await prefs.setString("role", admin.role);
        await prefs.setInt("adminId", admin.id);

        AppPermission.role = admin.role;

        return true;
      }

      errorMessage = "Invalid username or password";
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}