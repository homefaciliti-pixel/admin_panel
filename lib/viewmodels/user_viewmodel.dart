import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/services/api_service.dart';

class UserViewmodel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  List<UserModel> get paginatedUsers {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (end > users.length) {
      end = users.length;
    }

    if (start >= users.length) {
      return [];
    }
    return users.sublist(start, end);
  }

  int selectedEntries = 10;
  int currentPage = 1;

  List<UserModel> _allUsers = [];
  List<UserModel> users = [];

  UserViewmodel() {
    loadUsers();
  }

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    _allUsers = await _api.getUsers();
    users = List.from(_allUsers);

    isLoading = false;
    notifyListeners();
  }

  /// Total Pages
  int get totalPages {
    if (users.isEmpty) return 1;
    return (users.length / selectedEntries).ceil();
  }

  ///change Entries

  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  /// NEXT PAGE

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  /// Previous Page
    void previousPage(){
    if(currentPage>1){
      currentPage --;
      notifyListeners();
    }
    }
           ///search

     void searchUser(String value) {
    if (value.trim().isEmpty){
      users =List.from(_allUsers);

    }else{
      final keyword =value.toLowerCase();

      users = _allUsers.where((item){
        return item.name.toLowerCase().contains(keyword)||
        item.mobile.toLowerCase().contains(keyword)||
        item.email.toLowerCase().contains(keyword) ||
        item.address.toLowerCase().contains(keyword);


      }).toList();
    }
    currentPage =1;
    notifyListeners();
     }

          ///Delete

  Future<void> deleteUser(int id) async {
    final success = await _api.deleteUser(id);
    if (success) {
      _allUsers.removeWhere((e) => e.id == id);
      users = List.from(_allUsers);

      if (currentPage > totalPages) {
        currentPage = totalPages;
      }

      notifyListeners();
    }
  }
}
