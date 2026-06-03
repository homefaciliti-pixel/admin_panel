import 'package:flutter/material.dart';

import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  /// loading state
  bool isLoading = false;

  /// password hide/show
  bool obscurePassword = true;

  /// error message
  String? errorMessage;

  /// password visibility toggle
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  /// login method
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final success = await _authRepository.login(
        email: email,
        password: password,
      );

      if (!success) {
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