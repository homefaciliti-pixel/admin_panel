import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/dashboard_model.dart';



class DashboardViewModel extends ChangeNotifier {
  // ============================================================
  // API URL
  // ============================================================

  static const String dashboardUrl =
      'https://adminbackend-1-h03r.onrender.com/api/dashboard';

  static const String activePartnersUrl =
      'https://adminbackend-1-h03r.onrender.com/api/partners/active';

  // ============================================================
  // STATES
  // ============================================================

  bool isLoading = false;
  bool isRefreshing = false;
  bool isLoadingActivePartners = false;

  String? errorMessage;

  // ============================================================
  // MODEL
  // ============================================================

  DashboardModel? dashboardModel;

  // ============================================================
  // ACTIVE PARTNERS
  // ============================================================

  List<dynamic> activePartnersList = [];

  // ============================================================
  // FETCH DASHBOARD
  // ============================================================

  Future<void> fetchDashboard() async {
    if (isLoading) {
      return;
    }

    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await _fetchDashboardApi();

      // Dashboard data milte hi UI update
      notifyListeners();

      // Active partners background mein
      _fetchActivePartners();
    } catch (e) {
      debugPrint(
        'Dashboard API Error: $e',
      );

      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ============================================================
  // DASHBOARD API
  // ============================================================

  Future<void> _fetchDashboardApi() async {
    final response = await http
        .get(
      Uri.parse(dashboardUrl),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    )
        .timeout(
      const Duration(seconds: 15),
    );

    debugPrint(
      'Dashboard Status: ${response.statusCode}',
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'Dashboard API failed: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! Map<String, dynamic>) {
      throw Exception(
        'Invalid dashboard response',
      );
    }

    if (decoded['success'] != true) {
      throw Exception(
        decoded['message']?.toString() ??
            'Dashboard API failed',
      );
    }

    // ==========================================================
    // MODEL PARSE
    // ==========================================================

    dashboardModel =
        DashboardModel.fromJson(decoded);

    debugPrint(
      'Dashboard Cards: '
          '${dashboardModel?.data.length}',
    );
  }

  // ============================================================
  // ACTIVE PARTNERS
  // ============================================================

  Future<void> _fetchActivePartners() async {
    if (isLoadingActivePartners) {
      return;
    }

    isLoadingActivePartners = true;

    notifyListeners();

    try {
      final response = await http
          .get(
        Uri.parse(activePartnersUrl),
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      )
          .timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        return;
      }

      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic> &&
          decoded['success'] == true) {
        final data = decoded['data'];

        if (data is List) {
          activePartnersList = data;
        }
      }
    } catch (e) {
      debugPrint(
        'Active Partners Error: $e',
      );
    } finally {
      isLoadingActivePartners = false;

      notifyListeners();
    }
  }

  // ============================================================
  // GET CARD BY NAME
  // ============================================================

  DashboardCardModel? _getCard(
      String name,
      ) {
    final data = dashboardModel?.data;

    if (data == null) {
      return null;
    }

    for (final card in data) {
      if (card.name == name) {
        return card;
      }
    }

    return null;
  }

  // ============================================================
  // GET AMOUNT
  // ============================================================

  int _amountByName(
      String name,
      ) {
    return _getCard(name)?.totalAmount ?? 0;
  }

  // ============================================================
  // DASHBOARD GETTERS
  // ============================================================

  int get totalUsers {
    return _amountByName(
      'Total Users',
    );
  }

  int get totalCategories {
    return _amountByName(
      'Total Categories',
    );
  }

  int get totalServices {
    return _amountByName(
      'Total Services',
    );
  }

  int get totalPartners {
    return _amountByName(
      'Total Partners',
    );
  }

  int get totalOrders {
    return _amountByName(
      'Total Orders',
    );
  }

  int get todayOrders {
    return _amountByName(
      'Today Orders',
    );
  }

  int get completeOrders {
    return _amountByName(
      'Complete Orders',
    );
  }

  int get assignedOrders {
    return _amountByName(
      'Assigned Orders',
    );
  }

  int get inProgressOrders {
    return _amountByName(
      'In Progress Orders',
    );
  }

  int get cancelOrders {
    return _amountByName(
      'Cancel Orders',
    );
  }

  int get totalSupporters {
    return _amountByName(
      'Total Supporters',
    );
  }

  // ============================================================
  // ACTIVE PARTNERS
  // ============================================================

  int get activePartners {
    return activePartnersList.length;
  }

  // ============================================================
  // PENDING APPROVAL
  // ============================================================

  int get pendingApproval {
    return _amountByName(
      'Pending Partners',
    );
  }

  // ============================================================
  // EARNINGS
  // ============================================================

  String get subscriptionEarning {
    return '₹${_amountByName(
      'Subscription Earnings',
    )}';
  }

  String get orderEarning {
    return '₹${_amountByName(
      'Order Earnings',
    )}';
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> refreshDashboard() async {
    if (isRefreshing) {
      return;
    }

    isRefreshing = true;
    errorMessage = null;

    notifyListeners();

    try {
      await _fetchDashboardApi();

      notifyListeners();

      _fetchActivePartners();
    } catch (e) {
      debugPrint(
        'Dashboard Refresh Error: $e',
      );

      errorMessage = e.toString();
    } finally {
      isRefreshing = false;

      notifyListeners();
    }
  }
}
// class DashboardViewModel extends ChangeNotifier {
//   bool isLoading = false;
//   String? errorMessage;
//
//   /// API se aane wali cards list
//   List<Map<String, dynamic>> cards = [];
//   List<dynamic> activePartnersList = [];
//
//   Future<void> _fetchStats() async {
//     final response = await http.get(
//       Uri.parse('https://adminbackend-1-h03r.onrender.com/api/dashboard'),
//       headers: const {'Content-Type': 'application/json'},
//     );
//
//     final decoded = jsonDecode(response.body);
//
//     if (decoded is Map<String, dynamic> && decoded['success'] == true) {
//       final data = decoded['data'];
//
//       if (data is List) {
//         cards = data.whereType<Map<String, dynamic>>().toList();
//       } else {
//         errorMessage = 'Dashboard data list me nahi hai';
//       }
//     } else {
//       errorMessage = 'Dashboard response invalid hai';
//     }
//   }
//
//   Future<void> fetchActivePartners() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//           'https://adminbackend-1-h03r.onrender.com/api/partners/active',
//         ),
//         headers: const {'Content-Type': 'application/json'},
//       );
//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);
//         if (decoded is Map<String, dynamic> && decoded['success'] == true) {
//           activePartnersList = decoded['data'] as List<dynamic>;
//         }
//       }
//     } catch (e) {
//       debugPrint("Error fetching active partners: $e");
//     }
//   }
//
//   Future<void> fetchDashboard() async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       await Future.wait([_fetchStats(), fetchActivePartners()]);
//     } catch (e) {
//       errorMessage = 'API error: $e';
//     }
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   int _amountByName(String name) {
//     final item = cards.cast<Map<String, dynamic>?>().firstWhere(
//       (e) => (e?['name']?.toString() ?? '') == name,
//       orElse: () => null,
//     );
//
//     return item?['totalAmount'] ?? 0;
//   }
//
//   int get totalUsers => _amountByName('Total Users');
//   int get totalCategories => _amountByName('Total Categories');
//   int get totalServices => _amountByName('Total Services');
//   int get totalPartners => _amountByName('Total Partners');
//   int get activePartners {
//     final count = _amountByName('Active Partners');
//     return count > 0 ? count : activePartnersList.length;
//   }
//   int get pendingApproval => _amountByName('Pending Partners');
//
//   int get totalOrders => _amountByName('Total Orders');
//   int get todayOrders => _amountByName('Today Orders');
//   int get completeOrders => _amountByName('Complete Orders');
//   int get assignedOrders => _amountByName('Assigned Orders');
//   int get cancelOrders => _amountByName('Cancel Orders');
//   int get totalSupporters => _amountByName('Total Supporters');
//
//   String get subscriptionEarning =>
//       '₹${_amountByName('Subscription Earnings')}';
//
//   String get orderEarning => '₹${_amountByName('Order Earnings')}';
// }
