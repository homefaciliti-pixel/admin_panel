import 'dart:convert';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../service_model/reports_models/earning_report_model.dart';
import '../../service_model/reports_models/partner_report_model.dart';
import '../../service_model/reports_models/subscription_report_model.dart';
import '../../service_model/reports_models/user_report_model.dart';

enum ReportsTab { users, partners, earnings, subscriptions }

class ReportsViewModel extends ChangeNotifier {
  /// =========================================
  /// CURRENT TAB
  /// =========================================

  ReportsTab currentTab = ReportsTab.users;

  void changeTab(ReportsTab tab) {
    currentTab = tab;
    loadReportData();
  }

  /// =========================================
  /// DATE FILTERS
  /// =========================================

  DateTime? startDate;
  DateTime? endDate;

  void setStartDate(DateTime? date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime? date) {
    endDate = date;
    notifyListeners();
  }

  /// =========================================
  /// MASTER LISTS
  /// =========================================

  List<UserReportModel> _allUsers = [];
  List<PartnerReportModel> _allPartners = [];
  List<EarningReportModel> _allEarnings = [];
  List<SubscriptionReportModel> _allSubscriptions = [];

  /// =========================================
  /// FILTERED LISTS
  /// =========================================

  List<UserReportModel> users = [];
  List<PartnerReportModel> partners = [];
  List<EarningReportModel> earnings = [];
  List<SubscriptionReportModel> subscriptions = [];

  bool isLoading = false;
  final String _baseUrl = 'https://adminbackend-1-h03r.onrender.com/api';

  /// constructor
  ReportsViewModel() {
    loadReportData();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day-$month-$year';
  }

  String _getTabName() {
    switch (currentTab) {
      case ReportsTab.users:
        return 'users';
      case ReportsTab.partners:
        return 'partners';
      case ReportsTab.earnings:
        return 'earnings';
      case ReportsTab.subscriptions:
        return 'subscriptions';
    }
  }

  Future<void> loadReportData() async {
    isLoading = true;
    notifyListeners();

    try {
      final startStr = startDate != null
          ? _formatDate(startDate!)
          : '01-01-2020';
      final endStr = endDate != null ? _formatDate(endDate!) : '31-12-2030';
      const queryParam = '';
      const exportParam = 'none';

      final uri = Uri.parse('$_baseUrl/reports/${_getTabName()}').replace(
        queryParameters: {
          'startDate': startStr,
          'endDate': endStr,
          'query': queryParam,
          'export': exportParam,
        },
      );

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['success'] == true && body['data'] is List) {
          final data = body['data'] as List;
          switch (currentTab) {
            case ReportsTab.users:
              _allUsers = data
                  .map((json) => UserReportModel.fromJson(json))
                  .toList();
              users = List.from(_allUsers);
              break;
            case ReportsTab.partners:
              _allPartners = data
                  .map((json) => PartnerReportModel.fromJson(json))
                  .toList();
              partners = List.from(_allPartners);
              break;
            case ReportsTab.earnings:
              _allEarnings = data
                  .map((json) => EarningReportModel.fromJson(json))
                  .toList();
              earnings = List.from(_allEarnings);
              break;
            case ReportsTab.subscriptions:
              _allSubscriptions = data
                  .map((json) => SubscriptionReportModel.fromJson(json))
                  .toList();
              subscriptions = List.from(_allSubscriptions);
              break;
          }
        }
      }
    } catch (e) {
      print('ReportsViewModel - Error loading reports: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  /// =========================================
  /// APPLY FILTERS
  /// =========================================

  void applyFilters() {
    loadReportData();
  }

  /// =========================================
  /// RESET FILTERS
  /// =========================================

  void resetFilters() {
    startDate = null;
    endDate = null;
    loadReportData();
  }

  /// =========================================
  /// SEARCH USERS
  /// =========================================

  void searchUsers(String value) {
    if (value.trim().isEmpty) {
      users = List.from(_allUsers);
    } else {
      final keyword = value.toLowerCase();
      users = _allUsers.where((e) {
        return e.userName.toLowerCase().contains(keyword) ||
            e.locality.toLowerCase().contains(keyword) ||
            e.mobile.toLowerCase().contains(keyword);
      }).toList();
    }
    notifyListeners();
  }

  /// =========================================
  /// SEARCH PARTNERS
  /// =========================================

  void searchPartners(String value) {
    if (value.trim().isEmpty) {
      partners = List.from(_allPartners);
    } else {
      final keyword = value.toLowerCase();
      partners = _allPartners.where((e) {
        return e.partnerName.toLowerCase().contains(keyword) ||
            e.locality.toLowerCase().contains(keyword) ||
            e.mobile.toLowerCase().contains(keyword);
      }).toList();
    }
    notifyListeners();
  }

  /// =========================================
  /// SEARCH EARNINGS
  /// =========================================

  void searchEarnings(String value) {
    if (value.trim().isEmpty) {
      earnings = List.from(_allEarnings);
    } else {
      final keyword = value.toLowerCase();
      earnings = _allEarnings.where((e) {
        return e.source.toLowerCase().contains(keyword) ||
            e.title.toLowerCase().contains(keyword) ||
            e.locality.toLowerCase().contains(keyword) ||
            e.paymentMethod.toLowerCase().contains(keyword);
      }).toList();
    }
    notifyListeners();
  }

  /// =========================================
  /// SEARCH SUBSCRIPTIONS
  /// =========================================

  void searchSubscriptions(String value) {
    if (value.trim().isEmpty) {
      subscriptions = List.from(_allSubscriptions);
    } else {
      final keyword = value.toLowerCase();
      subscriptions = _allSubscriptions.where((e) {
        return e.partnerName.toLowerCase().contains(keyword) ||
            e.locality.toLowerCase().contains(keyword) ||
            e.planName.toLowerCase().contains(keyword);
      }).toList();
    }
    notifyListeners();
  }

  /// =========================================
  /// TAB TITLE
  /// =========================================

  String _getTabTitle() {
    switch (currentTab) {
      case ReportsTab.users:
        return "User Reports";
      case ReportsTab.partners:
        return "Partner Reports";
      case ReportsTab.earnings:
        return "Earnings Reports";
      case ReportsTab.subscriptions:
        return "Subscription Reports";
    }
  }

  /// =========================================
  /// PDF FILE NAME
  /// =========================================

  String _getPdfFileName() {
    switch (currentTab) {
      case ReportsTab.users:
        return "user_reports";
      case ReportsTab.partners:
        return "partner_reports";
      case ReportsTab.earnings:
        return "earning_reports";
      case ReportsTab.subscriptions:
        return "subscription_reports";
    }
  }

  /// =========================================
  /// PDF HEADERS
  /// =========================================

  List<String> _getPdfHeaders() {
    switch (currentTab) {
      case ReportsTab.users:
        return ["ID", "User Name", "Mobile", "Created At", "locality"];
      case ReportsTab.partners:
        return ["ID", "Partner Name", "Mobile", "Created At", "locality"];
      case ReportsTab.earnings:
        return [
          "ID",
          "Source",
          "Title",
          "Amount",
          "Payment Method",
          "Created At",
          "locality",
        ];
      case ReportsTab.subscriptions:
        return [
          "ID",
          "Partner Name",
          "Plan Name",
          "Amount",
          "Created At",
          "locality",
        ];
    }
  }

  /// =========================================
  /// PDF ROWS
  /// =========================================

  List<List<String>> _getPdfRows() {
    switch (currentTab) {
      case ReportsTab.users:
        return users
            .map(
              (e) => [
                e.id.toString(),
                e.userName,
                e.mobile,
                e.createdAt,
                e.locality,
              ],
            )
            .toList();

      case ReportsTab.partners:
        return partners
            .map(
              (e) => [
                e.id.toString(),
                e.partnerName,
                e.mobile,
                e.createdAt,
                e.locality,
              ],
            )
            .toList();

      case ReportsTab.earnings:
        return earnings
            .map(
              (e) => [
                e.id.toString(),
                e.source,
                e.title,
                "Rs ${e.amount.toStringAsFixed(0)}",
                e.paymentMethod,
                e.createdAt,
                e.locality,
              ],
            )
            .toList();

      case ReportsTab.subscriptions:
        return subscriptions
            .map(
              (e) => [
                e.id.toString(),
                e.partnerName,
                e.planName,
                "Rs${e.amount.toStringAsFixed(0)}",
                e.createdAt,
                e.locality,
              ],
            )
            .toList();
    }
  }

  /// =========================================
  /// EXPORT CURRENT TAB PDF
  /// =========================================

  Future<void> exportCurrentTabPdf() async {
    final pdf = pw.Document();

    final title = _getTabTitle();
    final headers = _getPdfHeaders();
    final rows = _getPdfRows();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(24),
        build: (context) {
          return [
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: headers,
              data: rows,
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.black),
              cellStyle: const pw.TextStyle(fontSize: 10),
              cellAlignment: pw.Alignment.centerLeft,
            ),
          ];
        },
      ),
    );

    final bytes = await pdf.save();

    await FileSaver.instance.saveFile(
      name: _getPdfFileName(),
      bytes: Uint8List.fromList(bytes),
      fileExtension: "pdf",
      mimeType: MimeType.pdf,
    );
  }
}
