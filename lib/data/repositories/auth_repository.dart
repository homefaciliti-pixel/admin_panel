import 'dart:async';

class AuthRepository {
  /// future me yaha API call lagegi
  /// abhi dummy login use kar rahe hain

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    /// dummy validation
    /// future me backend se replace hoga
    if (email == "admin@gmail.com" && password == "123456") {
      return true;
    }

    return false;
  }
}