// import 'package:flutter/material.dart';
// import '../../data/models/Settings models/state_model.dart';
//
// class StateViewModel extends ChangeNotifier {
//
//   /// =========================================
//   /// PAGINATION
//   /// =========================================
//
//   int selectedEntries = 10;
//
//   int currentPage = 1;
//
//   /// =========================================
//   /// MASTER LIST
//   /// =========================================
//
//   final List<StateModel> _allStates = [
//
//
//     StateModel(
//       id: 1,
//       name: "Rajasthan",
//       status: true,
//     ),
//
//     StateModel(
//       id: 2,
//       name: "Delhi",
//       status: true,
//     ),
//
//     StateModel(
//       id: 3,
//       name: "Uttar Pradesh",
//       status: false,
//     ),
//   ];
//
//   /// =========================================
//   /// ALL STATES
//   /// =========================================
//   ///
//   /// city dropdown ke liye full states list
//
//   List<StateModel> get allStates =>
//       List.from(_allStates);
//
//
//   /// visible list
//   List<StateModel> states = [];
//
//   /// constructor
//   StateViewModel() {
//
//     states = List.from(_allStates);
//   }
//
//   /// =========================================
//   /// TOTAL PAGES
//   /// =========================================
//
//   int get totalPages {
//
//     if (states.isEmpty) return 1;
//
//     return
//       (states.length / selectedEntries).ceil();
//   }
//
//   /// =========================================
//   /// PAGINATED DATA
//   /// =========================================
//
//   List<StateModel> get paginatedStates {
//
//     final start =
//         (currentPage - 1) * selectedEntries;
//
//     int end =
//         start + selectedEntries;
//
//     if (end > states.length) {
//       end = states.length;
//     }
//
//     if (start >= states.length) {
//       return [];
//     }
//
//     return states.sublist(start, end);
//   }
//
//   /// =========================================
//   /// CHANGE ENTRIES
//   /// =========================================
//
//   void changeEntries(int value) {
//
//     selectedEntries = value;
//
//     currentPage = 1;
//
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// NEXT PAGE
//   /// =========================================
//
//   void nextPage() {
//
//     if (currentPage < totalPages) {
//
//       currentPage++;
//
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// PREVIOUS PAGE
//   /// =========================================
//
//   void previousPage() {
//
//     if (currentPage > 1) {
//
//       currentPage--;
//
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// SEARCH
//   /// =========================================
//
//   void searchState(String value) {
//
//     if (value.trim().isEmpty) {
//
//       states =
//           List.from(_allStates);
//
//     } else {
//
//       final keyword =
//       value.toLowerCase();
//
//       states =
//           _allStates.where((item) {
//
//             return item.name
//                 .toLowerCase()
//                 .contains(keyword);
//
//           }).toList();
//     }
//
//     currentPage = 1;
//
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// TOGGLE STATUS
//   /// =========================================
//
//   void toggleStatus(int id) {
//
//     final index =
//     _allStates.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (index != -1) {
//
//       _allStates[index] =
//           _allStates[index].copyWith(
//
//             status:
//             !_allStates[index].status,
//           );
//
//       states =
//           List.from(_allStates);
//
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// ADD STATE
//   /// =========================================
//
//   void addState({
//
//     required String name,
//   }) {
//
//     final newState = StateModel(
//
//       id: _allStates.isEmpty
//           ? 1
//           : _allStates.last.id + 1,
//
//       name: name,
//
//       status: true,
//     );
//
//     _allStates.add(newState);
//
//     states =
//         List.from(_allStates);
//
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// UPDATE STATE
//   /// =========================================
//
//   void updateState({
//
//     required int id,
//
//     required String name,
//   }) {
//
//     final index =
//     _allStates.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (index != -1) {
//
//       _allStates[index] =
//           _allStates[index].copyWith(
//
//             name: name,
//           );
//
//       states =
//           List.from(_allStates);
//
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// DELETE STATE
//   /// =========================================
//
//   void deleteState(int id) {
//
//     _allStates.removeWhere(
//           (e) => e.id == id,
//     );
//
//     states =
//         List.from(_allStates);
//
//     if (currentPage > totalPages) {
//
//       currentPage = totalPages;
//     }
//
//     notifyListeners();
//   }
// }
