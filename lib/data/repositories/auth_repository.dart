import 'dart:async';

class AuthRepository {
  Future<Map<String, String>?> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    final users = <String, Map<String, String>>{
      "superadmin@gmail.com": {
        "password": "Home1184@*",
        "role": "super_admin",
        "name": "Super Admin",
      },
      "jitendar@gmail.com": {
        "password": "Jitendar1184@*",
        "role": "super_admin",
        "name": "Jitendar",
      },
      "neha@gmail.com": {
        "password": "Neha1184@*",
        "role": "super_admin",
        "name": "Neha",
      },
      "nirav@gmail.com": {
        "password": "Nirav1184@*",
        "role": "super_admin",
        "name": "Nirav",
      },
      "swayam@gmail.com": {
        "password": "Swayam1184@*",
        "role": "super_admin",
        "name": "Swayam",
      },

    };

    final aliases = <String, String>{
      "superadmin": "superadmin@gmail.com",
      "jitendar": "jitendar@gmail.com",
      "neha": "neha@gmail.com",
      "nirav": "nirav@gmail.com",
      "swayam": "swayam@gmail.com",

    };

    final key = email.toLowerCase().trim();
    final loginEmail = aliases[key] ?? key;

    final user = users[loginEmail];

    if (user != null && user["password"] == password) {
      return user;
    }

    return null;
  }
}
