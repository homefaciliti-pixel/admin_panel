// import 'package:flutter/material.dart';
// import '../data/models/partner_model.dart';
//
// /// partner details screen ke tabs
// enum PartnerDetailTab {
//   detail,
//   additional,
//   kyc,
//   wallet,
//   reviews,
//   bookings,
// }
//
// class PartnerViewModel extends ChangeNotifier {
//   /// =========================================
//   /// LIST / PAGINATION
//   /// =========================================
//
//   /// kitni entries show karni hai
//   int selectedEntries = 10;
//
//   /// current active page
//   int currentPage = 1;
//
//   /// master full list
//   final List<PartnerModel> _allPartners = [
//     PartnerModel(
//       id: 1,
//       name: "Govind",
//       email: "govindanuragi53@gmail.com",
//       mobile: "8009073091",
//       city: "Noida",
//       state: "Uttar Pradesh",
//       locality: "Sector 62",
//       address: "Near Metro Station",
//       image: "",
//       status: true,
//       isApproved: true,
//       gender: "Male",
//       experience: "3 Years",
//       services: ["AC Repair", "Fan Repair"],
//       aadhaarNumber: "XXXX-XXXX-1234",
//       panNumber: "ABCDE1234F",
//       bankName: "HDFC Bank",
//       accountNumber: "1234567890",
//       ifscCode: "HDFC0001234",
//       documents: [],
//       walletBalance: 5200,
//       totalEarnings: 25000,
//       withdrawnAmount: 19800,
//       totalBookings: 120,
//       completedBookings: 98,
//       cancelledBookings: 12,
//       pendingBookings: 10,
//       rating: 4.8,
//       totalReviews: 46,
//       createdAt: "06-05-2026 08:57 am",
//     ),
//     PartnerModel(
//       id: 2,
//       name: "Mahesh Kumar",
//       email: "maheshkumar918755@gmail.com",
//       mobile: "8619328820",
//       city: "Jaipur",
//       state: "Rajasthan",
//       locality: "Vaishali Nagar",
//       address: "Main Road",
//       image: "",
//       status: true,
//       isApproved: false,
//       gender: "Male",
//       experience: "2 Years",
//       services: ["Plumber"],
//       aadhaarNumber: "XXXX-XXXX-5678",
//       panNumber: "ABCDE5678G",
//       bankName: "SBI",
//       accountNumber: "9876543210",
//       ifscCode: "SBIN0005678",
//       documents: [],
//       walletBalance: 0,
//       totalEarnings: 0,
//       withdrawnAmount: 0,
//       totalBookings: 0,
//       completedBookings: 0,
//       cancelledBookings: 0,
//       pendingBookings: 0,
//       rating: 0,
//       totalReviews: 0,
//       createdAt: "20-03-2026 10:06 pm",
//     ),
//     PartnerModel(
//       id: 3,
//       name: "Sonali Sonawane",
//       email: "sonalideepak4554@gmail.com",
//       mobile: "9819021075",
//       city: "Mumbai",
//       state: "Maharashtra",
//       locality: "Andheri",
//       address: "Near Market",
//       image: "",
//       status: false,
//       isApproved: false,
//       gender: "Female",
//       experience: "4 Years",
//       services: ["Electrician", "Home Repair"],
//       aadhaarNumber: "XXXX-XXXX-9012",
//       panNumber: "ABCDE9012H",
//       bankName: "ICICI Bank",
//       accountNumber: "1122334455",
//       ifscCode: "ICIC0009012",
//       documents: [],
//       walletBalance: 0,
//       totalEarnings: 0,
//       withdrawnAmount: 0,
//       totalBookings: 0,
//       completedBookings: 0,
//       cancelledBookings: 0,
//       pendingBookings: 0,
//       rating: 0,
//       totalReviews: 0,
//       createdAt: "19-03-2026 02:24 pm",
//     ),
//   ];
//
//   /// current screen pe jo list dikh rahi hai
//   List<PartnerModel> partners = [];
//
//   PartnerViewModel() {
//     partners = List.from(_allPartners);
//   }
//
//   /// total pages
//   int get totalPages {
//     if (partners.isEmpty) return 1;
//     return (partners.length / selectedEntries).ceil();
//   }
//
//   /// =========================================
//   /// FILTERED LISTS
//   /// =========================================
//
//   /// approved partners list
//   List<PartnerModel> get approvedPartners {
//     return _allPartners.where((e) => e.isApproved).toList();
//   }
//
//   /// pending partners list
//   List<PartnerModel> get pendingPartners {
//     return _allPartners.where((e) => !e.isApproved).toList();
//   }
//
//   /// disApproved
//
//
//
//
//   /// =========================================
//   /// SEARCH / PAGINATION
//   /// =========================================
//
//   void changeEntries(int value) {
//     selectedEntries = value;
//     currentPage = 1;
//     notifyListeners();
//   }
//
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
//   void goToPage(int page) {
//     currentPage = page;
//     notifyListeners();
//   }
//
//   void searchPartner(String value) {
//     if (value.trim().isEmpty) {
//       partners = List.from(_allPartners);
//     } else {
//       final keyword = value.toLowerCase();
//
//       partners = _allPartners.where((item) {
//         return item.name.toLowerCase().contains(keyword) ||
//             item.email.toLowerCase().contains(keyword) ||
//             item.mobile.toLowerCase().contains(keyword) ||
//             item.city.toLowerCase().contains(keyword) ||
//             item.state.toLowerCase().contains(keyword) ||
//             item.locality.toLowerCase().contains(keyword);
//       }).toList();
//     }
//
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// STATUS / APPROVAL
//   /// =========================================
//
//   /// active / inactive toggle
//   void toggleStatus(int index, bool value) {
//     partners[index].status = value;
//
//     final id = partners[index].id;
//     final mainIndex = _allPartners.indexWhere((e) => e.id == id);
//
//     if (mainIndex != -1) {
//       _allPartners[mainIndex].status = value;
//     }
//
//     notifyListeners();
//   }
//
//   /// approve partnerTable
//   void approvePartner(int id) {
//     final index = _allPartners.indexWhere((e) => e.id == id);
//
//     if (index != -1) {
//       _allPartners[index] = _allPartners[index].copyWith(
//         isApproved: true,
//         status: true,
//       );
//       notifyListeners();
//     }
//   }
//   /// disapprove partner
//   /// approved list se remove ho jayega
//   void disapprovePartner(int id) {
//
//     final index =
//     _allPartners.indexWhere(
//           (e) => e.id == id,
//     );
//
//     if (index != -1) {
//
//       _allPartners[index] =
//           _allPartners[index].copyWith(
//
//             isApproved: true,
//
//             status: false,
//           );
//
//       /// IMPORTANT
//       /// visible UI list refresh
//       partners = List.from(_allPartners);
//
//       notifyListeners();
//     }
//   }
//   /// =========================================
//   /// SELECTED PARTNER
//   /// =========================================
//
//   PartnerModel? selectedPartner;
//
//   /// details screen ke liye selected partner set
//   void selectPartner(PartnerModel partner) {
//     selectedPartner = partner;
//     currentTab = PartnerDetailTab.detail;
//     notifyListeners();
//   }
//
//   void clearSelectedPartner() {
//     selectedPartner = null;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// DETAILS SCREEN TAB STATE
//   /// =========================================
//
//   PartnerDetailTab currentTab = PartnerDetailTab.detail;
//
//   void changeTab(PartnerDetailTab tab) {
//     currentTab = tab;
//     notifyListeners();
//   }
//
//   /// =========================================
//   /// UPDATE PARTNER
//   /// =========================================
//
//   void updatePartner(PartnerModel updatedPartner) {
//     final index = _allPartners.indexWhere((e) => e.id == updatedPartner.id);
//
//     if (index != -1) {
//       _allPartners[index] = updatedPartner;
//       partners = List.from(_allPartners);
//       notifyListeners();
//     }
//   }
//
//   /// =========================================
//   /// DELETE PARTNER
//   /// =========================================
//
//   void deletePartner(int id) {
//     _allPartners.removeWhere((e) => e.id == id);
//     partners = List.from(_allPartners);
//
//     if (currentPage > totalPages) {
//       currentPage = totalPages;
//     }
//
//     notifyListeners();
//   }
//
//   /// quick stats
//   int get totalApprovedCount => approvedPartners.length;
//   int get totalPendingCount => pendingPartners.length;
//
//
//
//
//                 /// pending approved
//
//
//   /// approved list load karne ke liye
//   void loadApprovedPartners() {
//     partners = List.from(approvedPartners);
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// pending list load karne ke liye
//   void loadPendingPartners() {
//     partners = List.from(pendingPartners);
//     currentPage = 1;
//     notifyListeners();
//   }
//
//   /// pending search
//   void searchPendingPartner(String value) {
//     if (value.trim().isEmpty) {
//       partners = List.from(pendingPartners);
//     } else {
//       final keyword = value.toLowerCase();
//
//       partners = pendingPartners.where((item) {
//         return item.name.toLowerCase().contains(keyword) ||
//             item.email.toLowerCase().contains(keyword) ||
//             item.mobile.toLowerCase().contains(keyword) ||
//             item.city.toLowerCase().contains(keyword) ||
//             item.state.toLowerCase().contains(keyword) ||
//             item.locality.toLowerCase().contains(keyword);
//       }).toList();
//     }
//
//     currentPage = 1;
//     notifyListeners();
//   }
//
// }
//
