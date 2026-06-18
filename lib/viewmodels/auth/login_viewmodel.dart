import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/App_permission/app_permission.dart';
import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool isLoading = false;
  bool obscurePassword = true;
  String? errorMessage;

  /// selected role
  String selectedRole = "super_admin";

  void changeRole(String role) {
    selectedRole = role;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final role = await _authRepository.login(
        email: email,
        password: password,
      );

      if (role != null) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("role", role);

        AppPermission.role = role;

        return true;
      } else {
        errorMessage = "Invalid email or password";
        return false;
      }
    } catch (e) {
      errorMessage = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    AppPermission.role = "";

    notifyListeners();
  }
}
