// import 'package:flutter/material.dart';
// import '../data/models/order_model.dart';
//
// class OrderViewModel extends ChangeNotifier {
//   /// =========================================
//   /// PAGINATION
//   /// =========================================
//
//   /// table me kitni rows dikhani hain
//   int selectedEntries = 10;
//
//   /// current page number
//   int currentPage = 1;
//
//   /// =========================================
//   /// MASTER ORDER LIST
//   /// =========================================
//   ///
//   /// ye original data hai
//   /// future me yaha API se data aayega
//
//   final List<OrderModel> _allOrders = [
//     OrderModel(
//       id: 1,
//       serviceRequestNumber: "SRN1001",
//       serviceName: "AC Repair",
//       serviceAmount: 499,
//       slotTime: "10:00 AM - 12:00 PM",
//       serviceDate: "11-05-2026",
//       city: "Delhi",
//       locality: "Laxmi Nagar",
//       status: "Pending",
//       vendorName: "",
//       createdAt: "10-05-2026 09:30 AM", address: 'jaipur',
//     ),
//     OrderModel(
//       id: 2,
//       serviceRequestNumber: "SRN1002",
//       serviceName: "Electrician",
//       serviceAmount: 299,
//       slotTime: "02:00 PM - 04:00 PM",
//       serviceDate: "11-05-2026",
//       city: "Jaipur",
//       locality: "Mansarovar",
//       status: "Assigned",
//       vendorName: "Govind",
//       createdAt: "10-05-2026 10:10 AM", address: 'full address',
//     ),
//     OrderModel(
//       id: 3,
//       serviceRequestNumber: "SRN1003",
//       serviceName: "Plumbing",
//       serviceAmount: 399,
//       slotTime: "04:00 PM - 06:00 PM",
//       serviceDate: "12-05-2026",
//       city: "Noida",
//       locality: "Sector 62",
//       status: "Completed",
//       vendorName: "Mahesh Kumar",
//       createdAt: "10-05-2026 11:45 AM", address: 'full add',
//     ),
//   ];
//
//   /// screen pe jo orders dikhne hain
//   List<OrderModel> orders = [];
//
//   /// constructor
//   OrderViewModel() {
//     orders = List.from(_allOrders);
//   }
//
//   /// =========================================
//   /// TOTAL PAGES
//   /// =========================================
//
//   int get totalPages {
//     if (orders.isEmpty) return 1;
//     return (orders.length / selectedEntries).ceil();
//   }
//
//   /// =========================================
//   /// PAGINATED DATA(current page ka data )
//   /// =========================================
//   ///
//   /// current page ke hisaab se slice return karega
//
//   List<OrderModel> get paginatedOrders {
//     final start = (currentPage - 1) * selectedEntries;
//     int end = start + selectedEntries;
//
//     if (end > orders.length) {
//       end = orders.length;
//     }
//
//     if (start >= orders.length) {
//       return [];
//     }
//
//     return orders.sublist(start, end);
//   }
//
//   /// =========================================
//   /// CHANGE ENTRIES
//   /// =========================================
//   ///
//   /// 10 / 20 / 50 / 100 rows
//
//   void changeEntries(int value) {
//     selectedEntries = value;
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// NEXT PAGE
//   /// =========================================
//
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
//
//   void previousPage() {
//     if (currentPage > 1) {
//       currentPage--;
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// SEARCH ORDER
//   /// =========================================
//   ///
//   /// request number, service name, city,
//   /// locality, vendor name, status pe search hoga
//
//   void searchOrder(String value) {
//     if (value.trim().isEmpty) {
//       orders = List.from(_allOrders);
//     } else {
//       final keyword = value.toLowerCase();
//
//       orders = _allOrders.where((item) {
//         return item.serviceRequestNumber.toLowerCase().contains(keyword) ||
//             item.serviceName.toLowerCase().contains(keyword) ||
//             item.city.toLowerCase().contains(keyword) ||
//             item.locality.toLowerCase().contains(keyword) ||
//             item.vendorName.toLowerCase().contains(keyword) ||
//             item.status.toLowerCase().contains(keyword);
//       }).toList();
//     }
//
//     /// search ke baad first page pe le aao
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// DELETE ORDER
//   /// =========================================
//   ///
//   /// list se order remove karega
//
//   void deleteOrder(int id) {
//     _allOrders.removeWhere((e) => e.id == id);
//     orders = List.from(_allOrders);
//
//     /// agar current page last page se aage chala gaya ho
//     if (currentPage > totalPages) {
//       currentPage = totalPages;
//     }
//
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// ASSIGN VENDOR
//   /// =========================================
//   ///
//   /// assign vendor button click pe use hoga
//
//   void assignVendor(int id, String vendorName) {
//     final index = _allOrders.indexWhere((e) => e.id == id);
//
//     if (index != -1) {
//       _allOrders[index] = _allOrders[index].copyWith(
//         status: "Assigned",
//         vendorName: vendorName,
//       );
//
//       orders = List.from(_allOrders);
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// STATUS UPDATE
//   /// =========================================
//   ///
//   /// future me manual status change ke kaam aayega
//
//   void updateStatus(int id, String status) {
//     final index = _allOrders.indexWhere((e) => e.id == id);
//
//     if (index != -1) {
//       _allOrders[index] = _allOrders[index].copyWith(
//         status: status,
//       );
//
//       orders = List.from(_allOrders);
//       notifyListeners();
//     }
//   }
//
//
//
//   /// =========================================
//   /// UNASSIGN VENDOR
//   /// =========================================
//   ///
//   /// vendor remove karke order ko pending me le jayega
//
//   void unassignVendor(int id) {
//     final index = _allOrders.indexWhere((e) => e.id == id);
//
//     if (index != -1) {
//       _allOrders[index] = _allOrders[index].copyWith(
//         vendorName: "",
//         status: "Pending",
//       );
//
//       orders = List.from(_allOrders);
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// QUICK STATS
//   /// =========================================
//
//   int get totalPendingCount =>
//       _allOrders.where((e) => e.status == "Pending").length;
//
//   int get totalAssignedCount =>
//       _allOrders.where((e) => e.status == "Assigned").length;
//
//   int get totalCompletedCount =>
//       _allOrders.where((e) => e.status == "Completed").length;
//
//   int get totalCancelledCount =>
//       _allOrders.where((e) => e.status == "Cancelled").length;
// }