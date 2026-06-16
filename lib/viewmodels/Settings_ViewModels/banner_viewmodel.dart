// import 'package:flutter/material.dart';
// import '../../data/models/Settings models/banner_model.dart';
// import '../../data/services/api_service.dart';
//
// class BannerViewModel extends ChangeNotifier {
//   final ApiService _api = ApiService();
//   bool isLoading = false;
//
//   /// PAGINATION
//   /// kitni entries show hongi
//   int selectedEntries = 10;
//
//   /// current page number
//   int currentPage = 1;
//
//   /// original list
//   final List<BannerModel> _allBanners = [];
//
//   /// visible list
//   List<BannerModel> banners = [];
//
//   /// constructor
//   BannerViewModel() {
//     loadBanners();
//   }
//
//   Future<void> loadBanners() async {
//     isLoading = true;
//     notifyListeners();
//
//     final list = await _api.getBanners();
//     _allBanners.clear();
//     _allBanners.addAll(list);
//     banners = List.from(_allBanners);
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   /// TOTAL PAGES
//   int get totalPages {
//     if (banners.isEmpty) return 1;
//     return (banners.length / selectedEntries).ceil();
//   }
//
//   /// PAGINATED DATA
//   List<BannerModel> get paginatedBanners {
//     final start = (currentPage - 1) * selectedEntries;
//     int end = start + selectedEntries;
//
//     if (end > banners.length) {
//       end = banners.length;
//     }
//
//     if (start >= banners.length) {
//       return [];
//     }
//
//     return banners.sublist(start, end);
//   }
//
//   /// CHANGE ENTRIES
//   void changeEntries(int value) {
//     selectedEntries = value;
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// NEXT PAGE
//   void nextPage() {
//     if (currentPage < totalPages) {
//       currentPage++;
//       notifyListeners();
//     }
//   }
//
//   /// PREVIOUS PAGE
//   void previousPage() {
//     if (currentPage > 1) {
//       currentPage--;
//       notifyListeners();
//     }
//   }
//
//   /// SEARCH BANNER
//   void searchBanner(String value) {
//     if (value.trim().isEmpty) {
//       banners = List.from(_allBanners);
//     } else {
//       final keyword = value.toLowerCase();
//
//       banners = _allBanners.where((item) {
//         return item.title.toLowerCase().contains(keyword);
//       }).toList();
//     }
//
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// TOGGLE STATUS
//   Future<void> toggleStatus(int id) async {
//     final index = _allBanners.indexWhere((e) => e.id == id);
//     if (index != -1) {
//       final item = _allBanners[index];
//       final updated = await _api.updateBanner(id, status: !item.status);
//       if (updated != null) {
//         _allBanners[index] = updated;
//         banners = List.from(_allBanners);
//         notifyListeners();
//       }
//     }
//   }
//
//   /// ADD BANNER
//   Future<void> addBanner({
//     required String title,
//     required String image,
//   }) async {
//     final newBanner = await _api.addBanner(title, image, true);
//     if (newBanner != null) {
//       _allBanners.add(newBanner);
//       banners = List.from(_allBanners);
//       notifyListeners();
//     }
//   }
//
//   /// UPDATE BANNER
//   Future<void> updateBanner({
//     required int id,
//     required String title,
//     required String image,
//   }) async {
//     final updated = await _api.updateBanner(id, title: title, image: image);
//     if (updated != null) {
//       final index = _allBanners.indexWhere((e) => e.id == id);
//       if (index != -1) {
//         _allBanners[index] = updated;
//         banners = List.from(_allBanners);
//         notifyListeners();
//       }
//     }
//   }
//
//   /// DELETE BANNER
//   Future<void> deleteBanner(int id) async {
//     final success = await _api.deleteBanner(id);
//     if (success) {
//       _allBanners.removeWhere((e) => e.id == id);
//       banners = List.from(_allBanners);
//
//       if (currentPage > totalPages) {
//         currentPage = totalPages;
//       }
//
//       notifyListeners();
//     }
//   }
// }