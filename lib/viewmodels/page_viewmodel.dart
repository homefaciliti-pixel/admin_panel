// import 'package:flutter/material.dart';
//
//
// class PageViewModel extends ChangeNotifier {
//
//   /// =====================================
//   /// PAGE LIST
//   /// =====================================
//   ///
//   /// future me API se data aayega
//
//   final List<PageModel> _allPages = [
//
//     PageModel(
//
//       id: 1,
//
//       title: "About Us",
//
//       description:
//       "This is about us description.",
//     ),
//
//     PageModel(
//
//       id: 2,
//
//       title:
//       "Refund and Cancellation",
//
//       description:
//       "Refund and cancellation policy content.",
//     ),
//
//     PageModel(
//
//       id: 3,
//
//       title:
//       "Terms And Conditions",
//
//       description:
//       "Terms and conditions content.",
//     ),
//
//     PageModel(
//
//       id: 4,
//
//       title:
//       "Privacy Policy",
//
//       description:
//       "Privacy policy content.",
//     ),
//   ];
//
//   /// visible list
//   List<PageModel> pages = [];
//
//   /// constructor
//   PageViewModel() {
//
//     pages =
//         List.from(_allPages);
//   }
//
//   /// =====================================
//   /// UPDATE PAGE
//   /// =====================================
//   ///
//   /// title + description edit karega
//
//   void updatePage({
//
//     required int id,
//
//     required String title,
//
//     required String description,
//   }) {
//
//     final index =
//     _allPages.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (index != -1) {
//
//       _allPages[index] =
//           _allPages[index].copyWith(
//
//             title: title,
//
//             description: description,
//           );
//
//       pages =
//           List.from(_allPages);
//
//       notifyListeners();
//     }
//   }
// }