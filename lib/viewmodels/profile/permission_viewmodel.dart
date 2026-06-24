import 'package:flutter/material.dart';

class PermissionViewModel extends ChangeNotifier {

  final Map<String, bool> permissions = {
    "Dashboard": true,
    "Category": true,
    "Partner": true,
    "Earnings": false,
    "Users": true,
    "Services": true,
    "Orders": false,
    "Pages": false,
    "Settings": true,
    "Reports": false,
    "Support": true,
  };

  void togglePermission(String key) {
    permissions[key] = !(permissions[key] ?? false);
    notifyListeners();
  }

  void selectAll() {
    permissions.updateAll((key, value) => true);
    notifyListeners();
  }

  void unSelectAll() {
    permissions.updateAll((key, value) => false);
    notifyListeners();
  }

  bool hasPermission(String key) {
    return permissions[key] ?? false;
  }
}