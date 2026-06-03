import 'package:flutter/material.dart';
import 'locality_model.dart';

class LocalityViewModel extends ChangeNotifier {
  /// =========================================
  /// PAGINATION
  /// =========================================

  /// table me kitni entries show hongi
  int selectedEntries = 10;

  /// current page number
  int currentPage = 1;

  /// =========================================
  /// MASTER LIST
  /// =========================================
  ///
  /// future me yaha API ka data aayega

  final List<LocalityModel> _allLocalities = [
    LocalityModel(
      id: 1,
      localityName: "Mansarovar",
      cityName: "Jaipur",
      stateName: "Rajasthan",
      status: true,
    ),
    LocalityModel(
      id: 2,
      localityName: "Sector 62",
      cityName: "Noida",
      stateName: "Uttar Pradesh",
      status: true,
    ),
    LocalityModel(
      id: 3,
      localityName: "Laxmi Nagar",
      cityName: "Delhi",
      stateName: "Delhi",
      status: false,
    ),
  ];

  /// visible list
  ///
  /// search ke baad yahi UI me show hoti hai
  List<LocalityModel> localities = [];

  /// constructor
  LocalityViewModel() {
    localities = List.from(_allLocalities);
  }

  /// =========================================
  /// ALL LOCALITIES
  /// =========================================
  ///
  /// agar kisi aur screen me full list chahiye ho

  List<LocalityModel> get allLocalities => List.from(_allLocalities);

  /// =========================================
  /// TOTAL PAGES
  /// =========================================

  int get totalPages {
    if (localities.isEmpty) return 1;
    return (localities.length / selectedEntries).ceil();
  }

  /// =========================================
  /// PAGINATED DATA
  /// =========================================

  List<LocalityModel> get paginatedLocalities {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (end > localities.length) {
      end = localities.length;
    }

    if (start >= localities.length) {
      return [];
    }

    return localities.sublist(start, end);
  }

  /// =========================================
  /// CHANGE ENTRIES
  /// =========================================

  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  /// =========================================
  /// NEXT PAGE
  /// =========================================

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  /// =========================================
  /// PREVIOUS PAGE
  /// =========================================

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  /// =========================================
  /// SEARCH LOCALITY
  /// =========================================
  ///
  /// locality + city + state pe search

  void searchLocality(String value) {
    if (value.trim().isEmpty) {
      localities = List.from(_allLocalities);
    } else {
      final keyword = value.toLowerCase();

      localities = _allLocalities.where((item) {
        return item.localityName.toLowerCase().contains(keyword) ||
            item.cityName.toLowerCase().contains(keyword) ||
            item.stateName.toLowerCase().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  /// =========================================
  /// TOGGLE STATUS
  /// =========================================

  void toggleStatus(int id) {
    final index = _allLocalities.indexWhere((e) => e.id == id);

    if (index != -1) {
      _allLocalities[index] = _allLocalities[index].copyWith(
        status: !_allLocalities[index].status,
      );

      localities = List.from(_allLocalities);
      notifyListeners();
    }
  }

  /// =========================================
  /// ADD LOCALITY
  /// =========================================

  void addLocality({
    required String localityName,
    required String cityName,
    required String stateName,
  }) {
    final newLocality = LocalityModel(
      id: _allLocalities.isEmpty ? 1 : _allLocalities.last.id + 1,
      localityName: localityName,
      cityName: cityName,
      stateName: stateName,
      status: true,
    );

    _allLocalities.add(newLocality);
    localities = List.from(_allLocalities);
    notifyListeners();
  }

  /// =========================================
  /// UPDATE LOCALITY
  /// =========================================

  void updateLocality({
    required int id,
    required String localityName,
    required String cityName,
    required String stateName,
  }) {
    final index = _allLocalities.indexWhere((e) => e.id == id);

    if (index != -1) {
      _allLocalities[index] = _allLocalities[index].copyWith(
        localityName: localityName,
        cityName: cityName,
        stateName: stateName,
      );

      localities = List.from(_allLocalities);
      notifyListeners();
    }
  }

  /// =========================================
  /// DELETE LOCALITY
  /// =========================================

  void deleteLocality(int id) {
    _allLocalities.removeWhere((e) => e.id == id);
    localities = List.from(_allLocalities);

    if (currentPage > totalPages) {
      currentPage = totalPages;
    }

    notifyListeners();
  }
}