// import 'package:flutter/material.dart';
// import '../../data/models/Settings models/city_model.dart';
// import '../../data/services/api_service.dart';
//
// class CityViewModel extends ChangeNotifier {
//   final ApiService _api = ApiService();
//   bool isLoading = false;
//
//   /// =========================================
//   /// PAGINATION
//   /// =========================================
//   int selectedEntries = 10;
//   int currentPage = 1;
//
//   /// =========================================
//   /// MASTER LIST
//   /// =========================================
//   final List<CityModel> _allCities = [];
//
//   /// visible list
//   List<CityModel> cities = [];
//
//   /// all cities list
//   List<CityModel> get allCities => List.from(_allCities);
//
//   /// =========================================
//   /// CONSTRUCTOR
//   /// =========================================
//   CityViewModel() {
//     loadCities();
//   }
//
//   Future<void> loadCities() async {
//     isLoading = true;
//     notifyListeners();
//
//     final list = await _api.getCities();
//     _allCities.clear();
//     _allCities.addAll(list);
//     cities = List.from(_allCities);
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// TOTAL PAGES
//   /// =========================================
//   int get totalPages {
//     if (cities.isEmpty) return 1;
//     return (cities.length / selectedEntries).ceil();
//   }
//
//   /// =========================================
//   /// PAGINATED DATA
//   /// =========================================
//   List<CityModel> get paginatedCities {
//     final start = (currentPage - 1) * selectedEntries;
//     int end = start + selectedEntries;
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
//   void changeEntries(int value) {
//     selectedEntries = value;
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// NEXT PAGE
//   /// =========================================
//   void nextPage() {
//     if (currentPage < totalPages) {
//       currentPage++;
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// PREVIOUS PAGE
//   /// =========================================
//   void previousPage() {
//     if (currentPage > 1) {
//       currentPage--;
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// SEARCH CITY
//   /// =========================================
//   void searchCity(String value) {
//     if (value.trim().isEmpty) {
//       cities = List.from(_allCities);
//     } else {
//       final keyword = value.toLowerCase();
//       cities = _allCities.where((item) {
//         return item.cityName.toLowerCase().contains(keyword) ||
//             item.stateName.toLowerCase().contains(keyword);
//       }).toList();
//     }
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// TOGGLE STATUS
//   /// =========================================
//   Future<void> toggleStatus(int id) async {
//     final index = _allCities.indexWhere((e) => e.id == id);
//     if (index != -1) {
//       final item = _allCities[index];
//       final updated = await _api.updateCity(id, status: !item.status);
//       if (updated != null) {
//         _allCities[index] = updated;
//         cities = List.from(_allCities);
//         notifyListeners();
//       }
//     }
//   }
//
//   /// =========================================
//   /// ADD CITY
//   /// =========================================
//   Future<void> addCity({
//     required String cityName,
//     required String stateName,
//   }) async {
//     final newCity = await _api.addCity(cityName, stateName, true);
//     if (newCity != null) {
//       _allCities.add(newCity);
//       cities = List.from(_allCities);
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// UPDATE CITY
//   /// =========================================
//   Future<void> updateCity({
//     required int id,
//     required String cityName,
//     required String stateName,
//   }) async {
//     final updated = await _api.updateCity(id, cityName: cityName, stateName: stateName);
//     if (updated != null) {
//       final index = _allCities.indexWhere((e) => e.id == id);
//       if (index != -1) {
//         _allCities[index] = updated;
//         cities = List.from(_allCities);
//         notifyListeners();
//       }
//     }
//   }
//
//   /// =========================================
//   /// DELETE CITY
//   /// =========================================
//   Future<void> deleteCity(int id) async {
//     final success = await _api.deleteCity(id);
//     if (success) {
//       _allCities.removeWhere((e) => e.id == id);
//       cities = List.from(_allCities);
//
//       if (currentPage > totalPages) {
//         currentPage = totalPages;
//       }
//       notifyListeners();
//     }
//   }
// }