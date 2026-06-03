// import 'package:flutter/material.dart';
// import '../data/models/service_model.dart';
//
// class ServiceViewModel extends ChangeNotifier {
//   /// =========================================
//   /// PAGINATION
//   /// =========================================
//   int selectedEntries = 10;
//   int currentPage = 1;
//
//   /// =========================================
//   /// MASTER LIST
//   /// =========================================
//   final List<ServiceModel> _allServices = [
//     ServiceModel(
//       id: 1,
//       title: "AC Repair",
//       category: "AC Service",
//       price: 2500,
//       discountPercent: 20,
//       discountPrice: 2000,
//       imageBytes: null,
//       description: "Professional AC repair service for home and office.",
//       highlights: [
//         "Certified technician",
//         "Quick service",
//         "Warranty included",
//       ],
//       rating: 4.8,
//       reviewsCount: 84,
//       serviceTime: "1-2 Hours",
//       status: true,
//     ),
//     ServiceModel(
//       id: 2,
//       title: "Plumbing",
//       category: "Home Service",
//       price: 299,
//       discountPercent: 10,
//       discountPrice: 269.1,
//       imageBytes: null,
//       description: "Complete plumbing solution including leakage fixing.",
//       highlights: [
//         "Leakage fix",
//         "On-time support",
//         "Professional tools",
//       ],
//       rating: 4.5,
//       reviewsCount: 52,
//       serviceTime: "45-60 Min",
//       status: true,
//     ),
//     ServiceModel(
//       id: 3,
//       title: "Electrician",
//       category: "Electrical",
//       price: 399,
//       discountPercent: 15,
//       discountPrice: 339.15,
//       imageBytes: null,
//       description: "Electric fitting and repair service.",
//       highlights: [
//         "Safe wiring work",
//         "Trained electrician",
//         "Fast support",
//       ],
//       rating: 4.2,
//       reviewsCount: 31,
//       serviceTime: "1 Hour",
//       status: false,
//     ),
//   ];
//
//   /// visible list
//   List<ServiceModel> services = [];
//
//   ServiceViewModel() {
//     services = List.from(_allServices);
//   }
//
//   /// =========================================
//   /// DISCOUNT CALCULATION
//   /// =========================================
//   double calculateDiscountPrice(double price, double discountPercent) {
//     final discounted = price - (price * discountPercent / 100);
//     return discounted < 0 ? 0 : discounted;
//   }
//
//   /// =========================================
//   /// TOTAL PAGES
//   /// =========================================
//   int get totalPages {
//     if (services.isEmpty) return 1;
//     return (services.length / selectedEntries).ceil();
//   }
//
//   /// =========================================
//   /// PAGINATED DATA
//   /// =========================================
//   List<ServiceModel> get paginatedServices {
//     final start = (currentPage - 1) * selectedEntries;
//     int end = start + selectedEntries;
//
//     if (start >= services.length) return [];
//     if (end > services.length) end = services.length;
//
//     return services.sublist(start, end);
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
//   /// NEXT / PREVIOUS PAGE
//   /// =========================================
//   void nextPage() {
//     if (currentPage < totalPages) {
//       currentPage++;
//       notifyListeners();
//     }
//   }
//
//   void previousPage() {
//     if (currentPage > 1) {
//       currentPage--;
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// SEARCH SERVICE
//   /// =========================================
//   void searchService(String value) {
//     if (value.trim().isEmpty) {
//       services = List.from(_allServices);
//     } else {
//       final keyword = value.toLowerCase();
//       services = _allServices.where((item) {
//         return item.title.toLowerCase().contains(keyword) ||
//             item.category.toLowerCase().contains(keyword) ||
//             item.description.toLowerCase().contains(keyword) ||
//             item.serviceTime.toLowerCase().contains(keyword);
//       }).toList();
//     }
//
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// DELETE SERVICE
//   /// =========================================
//   void deleteService(int id) {
//     _allServices.removeWhere((e) => e.id == id);
//     services = List.from(_allServices);
//
//     if (currentPage > totalPages) {
//       currentPage = totalPages;
//     }
//
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// TOGGLE STATUS
//   /// =========================================
//   void toggleStatus(int id) {
//     final index = _allServices.indexWhere((e) => e.id == id);
//
//     if (index != -1) {
//       _allServices[index] = _allServices[index].copyWith(
//         status: !_allServices[index].status,
//       );
//       services = List.from(_allServices);
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// ADD NEW SERVICE
//   /// =========================================
//   void addService({
//     required String title,
//     required String category,
//     required double price,
//     required double discountPercent,
//     required List<int>? imageBytes,
//     required String description,
//     required List<String> highlights,
//     required double rating,
//     required int reviewsCount,
//     required String serviceTime,
//   }) {
//     final discountPrice = calculateDiscountPrice(price, discountPercent);
//
//     final newService = ServiceModel(
//       id: _allServices.isEmpty ? 1 : _allServices.last.id + 1,
//       title: title,
//       category: category,
//       price: price,
//       discountPercent: discountPercent,
//       discountPrice: discountPrice,
//       imageBytes: imageBytes,
//       description: description,
//       highlights: highlights,
//       rating: rating,
//       reviewsCount: reviewsCount,
//       serviceTime: serviceTime,
//       status: true,
//     );
//
//     _allServices.add(newService);
//     services = List.from(_allServices);
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// UPDATE SERVICE
//   /// =========================================
//   void updateService({
//     required int id,
//     required String title,
//     required String category,
//     required double price,
//     required double discountPercent,
//     required List<int>? imageBytes,
//     required String description,
//     required List<String> highlights,
//     required double rating,
//     required int reviewsCount,
//     required String serviceTime,
//   }) {
//     final index = _allServices.indexWhere((e) => e.id == id);
//
//     if (index != -1) {
//       final discountPrice = calculateDiscountPrice(price, discountPercent);
//
//       _allServices[index] = _allServices[index].copyWith(
//         title: title,
//         category: category,
//         price: price,
//         discountPercent: discountPercent,
//         discountPrice: discountPrice,
//         imageBytes: imageBytes,
//         description: description,
//         highlights: highlights,
//         rating: rating,
//         reviewsCount: reviewsCount,
//         serviceTime: serviceTime,
//       );
//
//       services = List.from(_allServices);
//       notifyListeners();
//     }
//   }
// }