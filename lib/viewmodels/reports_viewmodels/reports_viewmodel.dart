import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


import '../../data/models/reports_models/earning_report_model.dart';
import '../../data/models/reports_models/partner_report_model.dart';
import '../../data/models/reports_models/subscription_report_model.dart';
import '../../data/models/reports_models/user_report_model.dart';

enum ReportsTab {
  users,
  partners,
  earnings,
  subscriptions,
}

class ReportsViewModel extends ChangeNotifier {
  /// =========================================
  /// CURRENT TAB
  /// =========================================

  ReportsTab currentTab = ReportsTab.users;

  void changeTab(ReportsTab tab) {
    currentTab = tab;
    notifyListeners();
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
  ///
  /// future me yahi backend/API se aayega

  final List<UserReportModel> _allUsers = [
    UserReportModel(
      id: 1,
      userName: "Rahul Sharma",
      mobile: "9876543210",
      createdAt: "2026-05-02",
      locality: 'jaipur',
    ),
    UserReportModel(
      id: 2,
      userName: "Neha Singh",
      mobile: "9123456780",
      createdAt: "2026-05-10",
      locality: 'udaipur',
    ),
    UserReportModel(
      id: 3,
      userName: "Aman Verma",
      mobile: "9988776655",
      createdAt: "2026-05-18",
      locality: 'jodhpur',
    ),
  ];

  final List<PartnerReportModel> _allPartners = [
    PartnerReportModel(
      id: 1,
      partnerName: "Govind",
      mobile: "9000000001",
      createdAt: "2026-05-03",
      locality: 'jaipur',
    ),
    PartnerReportModel(
      id: 2,
      partnerName: "Mahesh Kumar",
      mobile: "9000000002",
      createdAt: "2026-05-12",
      locality: 'kota',
    ),
    PartnerReportModel(
      id: 3,
      partnerName: "Sonali",
      mobile: "9000000003",
      createdAt: "2026-05-20",
      locality: 'jaipur',
    ),
  ];

  final List<EarningReportModel> _allEarnings = [
    EarningReportModel(
      id: 1,
      source: "Booking",
      title: "AC Repair",
      amount: 1200,
      paymentMethod: "UPI",
      createdAt: "2026-05-04", locality: 'jaipur',
    ),
    EarningReportModel(
      id: 2,
      source: "Subscription",
      title: "Partner Verification",
      amount: 100,
      paymentMethod: "Cash",
      createdAt: "2026-05-14", locality: 'udaipur',
    ),
    EarningReportModel(
      id: 3,
      source: "Booking",
      title: "Plumbing",
      amount: 800,
      paymentMethod: "Card",
      createdAt: "2026-05-22", locality: 'sikar',
    ),
  ];

  final List<SubscriptionReportModel> _allSubscriptions = [
    SubscriptionReportModel(
      id: 1,
      partnerName: "Govind",
      planName: "Partner Verification",
      amount: 100,
      createdAt: "2026-05-03", locality: 'jodhpur',
    ),
    SubscriptionReportModel(
      id: 2,
      partnerName: "Mahesh Kumar",
      planName: "Partner Verification",
      amount: 100,
      createdAt: "2026-05-18", locality: 'jaipur',
    ),
  ];

  /// =========================================
  /// FILTERED LISTS
  /// =========================================

  List<UserReportModel> users = [];
  List<PartnerReportModel> partners = [];
  List<EarningReportModel> earnings = [];
  List<SubscriptionReportModel> subscriptions = [];

  /// constructor
  ReportsViewModel() {
    users = List.from(_allUsers);
    partners = List.from(_allPartners);
    earnings = List.from(_allEarnings);
    subscriptions = List.from(_allSubscriptions);
  }

  /// =========================================
  /// DATE PARSER
  /// =========================================

  DateTime? _parseDate(String value) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  /// =========================================
  /// CHECK DATE RANGE
  /// =========================================

  bool _isInRange(String dateString) {
    final itemDate = _parseDate(dateString);
    if (itemDate == null) return false;

    final start = startDate;
    final end = endDate;

    if (start != null &&
        itemDate.isBefore(
          DateTime(start.year, start.month, start.day),
        )) {
      return false;
    }

    if (end != null &&
        itemDate.isAfter(
          DateTime(end.year, end.month, end.day, 23, 59, 59),
        )) {
      return false;
    }

    return true;
  }

  /// =========================================
  /// APPLY FILTERS
  /// =========================================

  void applyFilters() {
    users = _allUsers.where((e) => _isInRange(e.createdAt)).toList();
    partners = _allPartners.where((e) => _isInRange(e.createdAt)).toList();
    earnings = _allEarnings.where((e) => _isInRange(e.createdAt)).toList();
    subscriptions = _allSubscriptions.where((e) => _isInRange(e.createdAt)).toList();

    notifyListeners();
  }

  /// =========================================
  /// RESET FILTERS
  /// =========================================

  void resetFilters() {
    startDate = null;
    endDate = null;

    users = List.from(_allUsers);
    partners = List.from(_allPartners);
    earnings = List.from(_allEarnings);
    subscriptions = List.from(_allSubscriptions);

    notifyListeners();
  }

  /// =========================================
  /// SEARCH USERS
  /// =========================================

  void searchUsers(String value) {
    if (value.trim().isEmpty) {
      users = _allUsers.where((e) => _isInRange(e.createdAt)).toList();
    } else {
      final keyword = value.toLowerCase();
      users = _allUsers.where((e) {
        return _isInRange(e.createdAt) &&
            (e.userName.toLowerCase().contains(keyword) ||
                e.locality.toLowerCase().contains(keyword)||
                e.mobile.toLowerCase().contains(keyword));
      }).toList();
    }
    notifyListeners();
  }

  /// =========================================
  /// SEARCH PARTNERS
  /// =========================================

  void searchPartners(String value) {
    if (value.trim().isEmpty) {
      partners = _allPartners.where((e) => _isInRange(e.createdAt)).toList();
    } else {
      final keyword = value.toLowerCase();
      partners = _allPartners.where((e) {
        return _isInRange(e.createdAt) &&
            (e.partnerName.toLowerCase().contains(keyword) ||
                e.locality.toLowerCase().contains(keyword)||
                e.mobile.toLowerCase().contains(keyword));
      }).toList();
    }
    notifyListeners();
  }

  /// =========================================
  /// SEARCH EARNINGS
  /// =========================================

  void searchEarnings(String value) {
    if (value.trim().isEmpty) {
      earnings = _allEarnings.where((e) => _isInRange(e.createdAt)).toList();
    } else {
      final keyword = value.toLowerCase();
      earnings = _allEarnings.where((e) {
        return _isInRange(e.createdAt) &&
            (e.source.toLowerCase().contains(keyword) ||
                e.title.toLowerCase().contains(keyword) ||
                e.locality.toLowerCase().contains(keyword)||
                e.paymentMethod.toLowerCase().contains(keyword));
      }).toList();
    }
    notifyListeners();
  }

  /// =========================================
  /// SEARCH SUBSCRIPTIONS
  /// =========================================

  void searchSubscriptions(String value) {
    if (value.trim().isEmpty) {
      subscriptions = _allSubscriptions.where((e) => _isInRange(e.createdAt)).toList();
    } else {
      final keyword = value.toLowerCase();
      subscriptions = _allSubscriptions.where((e) {
        return _isInRange(e.createdAt) &&
            (e.partnerName.toLowerCase().contains(keyword) ||
                e.locality.toLowerCase().contains(keyword)||
                e.planName.toLowerCase().contains(keyword));
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
        return ["ID", "Source", "Title", "Amount", "Payment Method", "Created At", "locality"];
      case ReportsTab.subscriptions:
        return ["ID", "Partner Name", "Plan Name", "Amount", "Created At", "locality"];
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
            e.locality
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
             e.locality
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
            e.locality
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
            e.locality
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
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: headers,
              data: rows,
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.black,
              ),
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