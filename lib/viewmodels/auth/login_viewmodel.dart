import 'package:flutter/cupertino.dart';

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
      final success = await _authRepository.login(
        email: email,
        password: password,
      );

      if (success) {
        AppPermission.role = selectedRole;
      } else {
        errorMessage = "Invalid email or password";
      }

      return success;
    } catch (e) {
      errorMessage = "Something went wrong";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
