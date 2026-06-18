import 'dart:async';

class AuthRepository {
  /// future me yaha API call lagegi
  /// abhi dummy login use kar rahe hain

  Future<String?> login({
    required String email,
    required String password,
  }) async {

    await Future.delayed(const Duration(seconds: 1));

    if (email == "superadmin@gmail.com" &&
        password == "Home1184@*") {
      return "super_admin";
    }

    if (email == "admin@gmail.com" &&
        password == "Home1184@") {
      return "admin";
    }

    return null;
  }
}
