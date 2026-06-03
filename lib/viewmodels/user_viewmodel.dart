// import 'dart:math';
//
// import 'package:admin_panel/data/models/user_model.dart';
// import 'package:flutter/material.dart';
//
// import '../service_model/Users_model/user_model.dart';
//
// class UserViewmodel extends ChangeNotifier {
//   //Pagiation
//
//
//   //// current page ke users
//
//   List<UserModel>get paginatedUsers{
//     final start = (currentPage -1)*selectedEntries;
//     int end = start +selectedEntries;
//
//     if(end >users.length){
//       end =users.length;
//     }
//
//     if(start >= users.length){
//       return[];
//     }
//     return users.sublist(start,end );
//   }
//
//   // kitni entris show hongi
//
//   int selectedEntries = 10;
//
//   //
//   int currentPage = 1;
//
//   /// master List
//
//   final List<UserModel> _allUsers = [
//     UserModel(
//       id: 1,
//       name: "Rahul Sharma",
//       mobile: "9876543210",
//       email: "rahul@gmail.com",
//       address: "Delhi, India",
//     ),
//     UserModel(
//       id: 2,
//       name: "Aman Verma",
//       mobile: "9988776655",
//       email: "aman@gmail.com",
//       address: "Jaipur, Rajasthan",
//     ),
//     UserModel(
//       id: 3,
//       name: "Neha Singh",
//       mobile: "9123456780",
//       email: "neha@gmail.com",
//       address: "Noida, Uttar Pradesh",
//     ),
//   ];
//   // visble List
//
//   List<UserModel> users = [];
//   // constructor
//   UserViewmodel() {
//     users = List.from(_allUsers);
//   }
//
//   /// Total Pages
//   int get totalPages {
//     if (users.isEmpty) return 1;
//     return (users.length / selectedEntries).ceil();
//   }
//
//   ///change Entries
//
//   void changeEntries(int value) {
//     selectedEntries = value;
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// NEXT PAGE
//
//   void nextPage() {
//     if (currentPage < totalPages) {
//       currentPage++;
//       notifyListeners();
//     }
//   }
//
//   /// Previous Page
//     void previousPage(){
//     if(currentPage>1){
//       currentPage --;
//       notifyListeners();
//     }
//     }
//            ///search
//
//      void searchUser(String value) {
//     if (value.trim().isEmpty){
//       users =List.from(_allUsers);
//
//     }else{
//       final keyword =value.toLowerCase();
//
//       users = _allUsers.where((item){
//         return item.name.toLowerCase().contains(keyword)||
//         item.mobile.toLowerCase().contains(keyword)||
//         item.email.toLowerCase().contains(keyword) ||
//         item.address.toLowerCase().contains(keyword);
//
//
//       }).toList();
//     }
//     currentPage =1;
//     notifyListeners();
//      }
//
//           ///Delete
//
//   void deleteUser(int id) {
//     _allUsers.removeWhere((e) => e.id == id);
//     users = List.from(_allUsers);
//
//     if (currentPage > totalPages) {
//       currentPage = totalPages;
//     }
//
//     notifyListeners();
//   }
// }
