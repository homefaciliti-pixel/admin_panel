// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import '../data/models/category_model.dart';
//
// class CategoryViewModel extends ChangeNotifier {
//
//   /// entries per page
//   int selectedEntries = 10;
//
//   /// current page
//   int currentPage = 1;
//
//   /// visible list
//   List<CategoryModel> categories = [];
//
//   /// original list
//   final List<CategoryModel> _allCategories = [
//
//     CategoryModel(
//       id: 1,
//       title:
//       "Professional Laundry & Grooming Services",
//       parent: "Contractors",
//       image: "",
//       imageBytes: null,
//       status: true,
//     ),
//
//     CategoryModel(
//       id: 2,
//       title: "AC Repair",
//       parent: "Home Services",
//       image: "",
//       imageBytes: null,
//       status: true,
//     ),
//
//     CategoryModel(
//       id: 3,
//       title: "Electrician",
//       parent: "Home Services",
//       image: "",
//       imageBytes: null,
//       status: true,
//     ),
//   ];
//
//   CategoryViewModel() {
//     categories = List.from(_allCategories);
//   }
//
//   /// total pages
//   int get totalPages {
//     if (categories.isEmpty) return 1;
//
//     return (categories.length / selectedEntries)
//         .ceil();
//   }
//
//   /// change dropdown entries
//   void changeEntries(int value) {
//     selectedEntries = value;
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// next page
//   void nextPage() {
//     if (currentPage < totalPages) {
//       currentPage++;
//       notifyListeners();
//     }
//   }
//
//   /// previous page
//   void previousPage() {
//     if (currentPage > 1) {
//       currentPage--;
//       notifyListeners();
//     }
//   }
//
//   /// direct page
//   void goToPage(int page) {
//     currentPage = page;
//     notifyListeners();
//   }
//
//   /// search category
//   void searchCategory(String value) {
//
//     if (value.trim().isEmpty) {
//
//       categories =
//           List.from(_allCategories);
//
//     } else {
//
//       final keyword =
//       value.toLowerCase();
//
//       categories =
//           _allCategories.where((item) {
//             return item.title
//                 .toLowerCase()
//                 .contains(keyword) ||
//                 item.parent
//                     .toLowerCase()
//                     .contains(keyword);
//           }).toList();
//     }
//
//     currentPage = 1;
//
//     notifyListeners();
//   }
//
//   /// toggle status
//   void toggleStatus(
//       int index,
//       bool value,
//       ) {
//     categories[index].status = value;
//
//     /// sync original list
//     final id = categories[index].id;
//
//     final mainIndex =
//     _allCategories.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (mainIndex != -1) {
//       _allCategories[mainIndex]
//           .status = value;
//     }
//
//     notifyListeners();
//   }
//
//   /// add category
//   void addCategory(
//       String title,
//       String parent,
//       String image,
//       Uint8List? imageBytes,
//       ) {
//     final item = CategoryModel(
//       id: _allCategories.length + 1,
//       title: title,
//       parent: parent,
//       image: image,
//       imageBytes: imageBytes,
//       status: true,
//     );
//
//     _allCategories.add(item);
//
//     categories =
//         List.from(_allCategories);
//
//     notifyListeners();
//   }
//
//   /// delete category
//   void deleteCategory(int id) {
//     _allCategories.removeWhere(
//           (e) => e.id == id,
//     );
//
//     categories =
//         List.from(_allCategories);
//
//     if (currentPage > totalPages) {
//       currentPage = totalPages;
//     }
//
//     notifyListeners();
//   }
//
//   /// update category
//   void updateCategory(
//       int id,
//       String title,
//       String parent,
//       String image,
//       Uint8List? imageBytes,
//       ) {
//     final index =
//     _allCategories.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (index != -1) {
//
//       final old =
//       _allCategories[index];
//
//       _allCategories[index] =
//           old.copyWith(
//             title: title,
//             parent: parent,
//             image:
//             image.isEmpty
//                 ? old.image
//                 : image,
//             imageBytes:
//             imageBytes ??
//                 old.imageBytes,
//           );
//     }
//
//     categories =
//         List.from(_allCategories);
//
//     notifyListeners();
//   }
// }