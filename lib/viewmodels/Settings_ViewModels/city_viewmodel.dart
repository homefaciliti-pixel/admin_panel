// import 'package:flutter/material.dart';
//
// import '../../data/models/Settings models/city_model.dart';
//
//
// class CityViewModel extends ChangeNotifier {
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
//   ///
//   /// original data
//   /// future me API se aayega
//
//   final List<CityModel> _allCities = [
//
//
//     CityModel(
//       id: 1,
//       cityName: "Jaipur",
//       stateName: "Rajasthan",
//       status: true,
//     ),
//
//     CityModel(
//       id: 2,
//       cityName: "Delhi",
//       stateName: "Delhi",
//       status: true,
//     ),
//
//     CityModel(
//       id: 3,
//       cityName: "Noida",
//       stateName: "Uttar Pradesh",
//       status: false,
//     ),
//   ];
//
//   /// visible list
//   ///
//   /// search/filter ke baad
//   /// yahi UI me show hoti hai
//
//   List<CityModel> cities = [];
//   /// all cities list
//   List<CityModel> get allCities => List.from(_allCities);
//
//   /// =========================================
//   /// CONSTRUCTOR
//   /// =========================================
//
//   CityViewModel() {
//
//     cities =
//         List.from(_allCities);
//   }
//
//   /// =========================================
//   /// TOTAL PAGES
//   /// =========================================
//
//   int get totalPages {
//
//     if (cities.isEmpty) return 1;
//
//     return
//       (cities.length / selectedEntries).ceil();
//   }
//
//   /// =========================================
//   /// PAGINATED DATA
//   /// =========================================
//
//   List<CityModel> get paginatedCities {
//
//     final start =
//         (currentPage - 1) * selectedEntries;
//
//     int end =
//         start + selectedEntries;
//
//     if (end > cities.length) {
//       end = cities.length;
//     }
//
//     if (start >= cities.length) {
//       return [];
//     }
//
//     return cities.sublist(start, end);
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
//   /// SEARCH CITY
//   /// =========================================
//   ///
//   /// city + state dono pe search
//
//   void searchCity(String value) {
//
//     if (value.trim().isEmpty) {
//
//       cities =
//           List.from(_allCities);
//
//     } else {
//
//       final keyword =
//       value.toLowerCase();
//
//       cities =
//           _allCities.where((item) {
//
//             return item.cityName
//                 .toLowerCase()
//                 .contains(keyword)
//
//                 ||
//
//                 item.stateName
//                     .toLowerCase()
//                     .contains(keyword);
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
//     _allCities.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (index != -1) {
//
//       _allCities[index] =
//           _allCities[index].copyWith(
//
//             status:
//             !_allCities[index].status,
//           );
//
//       cities =
//           List.from(_allCities);
//
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// ADD CITY
//   /// =========================================
//
//   void addCity({
//
//     required String cityName,
//
//     required String stateName,
//   }) {
//
//     final newCity = CityModel(
//
//       id: _allCities.isEmpty
//           ? 1
//           : _allCities.last.id + 1,
//
//       cityName: cityName,
//
//       stateName: stateName,
//
//       status: true,
//     );
//
//     _allCities.add(newCity);
//
//     cities =
//         List.from(_allCities);
//
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// UPDATE CITY
//   /// =========================================
//
//   void updateCity({
//
//     required int id,
//
//     required String cityName,
//
//     required String stateName,
//   }) {
//
//     final index =
//     _allCities.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (index != -1) {
//
//       _allCities[index] =
//           _allCities[index].copyWith(
//
//             cityName: cityName,
//
//             stateName: stateName,
//           );
//
//       cities =
//           List.from(_allCities);
//
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// DELETE CITY
//   /// =========================================
//
//   void deleteCity(int id) {
//
//     _allCities.removeWhere(
//           (e) => e.id == id,
//     );
//
//     cities =
//         List.from(_allCities);
//
//     if (currentPage > totalPages) {
//
//       currentPage = totalPages;
//     }
//
//     notifyListeners();
//   }
// }