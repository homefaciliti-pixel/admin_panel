import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service_model/support model/support_detail_model.dart';
import '../service_model/support model/support_model.dart';

class SupportAuth extends ChangeNotifier {
  static const String _baseUrl =
      "https://adminbackend-1-h03r.onrender.com/api";

  final List<SupportModel> _allTickets = [];
  List<SupportModel> tickets = [];

  bool isLoading = false;
  String? errorMessage;

  int selectedEntries = 10;
  int currentPage = 1;

  SupportModel? selectedTicket;

  SupportDetailModel? ticketDetail;


  /// ===============================
  /// GETTERS
  /// ===============================

  int get totalPages {
    if (tickets.isEmpty) return 1;
    return (tickets.length / selectedEntries).ceil();
  }

  List<SupportModel> get paginatedTickets {
    final start = (currentPage - 1) * selectedEntries;
    final end = start + selectedEntries;

    if (start >= tickets.length) return [];

    return tickets.sublist(
      start,
      end > tickets.length ? tickets.length : end,
    );
  }

  /// ===============================
  /// LOAD SUPPORT TICKETS
  /// ===============================

  Future<void> loadSupportTickets() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response =
      await http.get(Uri.parse("$_baseUrl/support"));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json["success"] == true) {
          final list = json["data"] as List;

          _allTickets
            ..clear()
            ..addAll(
              list.map((e) => SupportModel.fromJson(e)).toList(),
            );

          tickets = List.from(_allTickets);
        } else {
          errorMessage = "Support tickets load nahi hue";
        }
      } else {
        errorMessage = "Server Error : ${response.statusCode}";
      }
    } catch (e) {
      errorMessage = e.toString();
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ===============================
  /// SEARCH
  /// ===============================

  void searchTicket(String value) {
    if (value.trim().isEmpty) {
      tickets = List.from(_allTickets);
    } else {
      final keyword = value.toLowerCase();

      tickets = _allTickets.where((item) {
        return item.userName.toLowerCase().contains(keyword) ||
            item.email.toLowerCase().contains(keyword) ||
            item.mobile.toLowerCase().contains(keyword) ||
            item.subject.toLowerCase().contains(keyword) ||
            item.status.toLowerCase().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  /// ===============================
  /// PAGINATION
  /// ===============================

  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  /// ===============================
  /// SELECT TICKET
  /// ===============================

  void selectTicket(SupportModel ticket) {
    selectedTicket = ticket;
    notifyListeners();
  }

  void clearSelectedTicket() {
    selectedTicket = null;
    notifyListeners();
  }

  /// ===============================
  /// DELETE TICKET
  /// ===============================

  Future<bool> deleteTicket(int id) async {
    try {
      final response =
      await http.delete(Uri.parse("$_baseUrl/support/$id"));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json["success"] == true) {
          _allTickets.removeWhere((e) => e.id == id);
          tickets.removeWhere((e) => e.id == id);

          if (selectedTicket?.id == id) {
            selectedTicket = null;
          }

          if (currentPage > totalPages) {
            currentPage = totalPages;
          }

          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }
  /// ===============================
  /// GET SUPPORT DETAIL
  /// ===============================

  Future<bool> getSupportDetails(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      final response =
      await http.get(Uri.parse("$_baseUrl/support/$id"));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json["success"] == true) {
          ticketDetail = SupportDetailModel.fromJson(json["data"]);
          notifyListeners();
          return true;
        }
      }
    } catch (e) {
      debugPrint("getSupportDetails : $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return false;
  }
  /// ===============================
  /// CLOSE TICKET
  /// ===============================

  Future<bool> closeTicket(int id) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/support/$id"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "status": "Closed",
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json["success"] == true) {
          final updated =
          SupportDetailModel.fromJson(json["data"]);

          ticketDetail = updated;

          final index =
          _allTickets.indexWhere((e) => e.id == id);

          if (index != -1) {
            _allTickets[index] = SupportModel(
              id: updated.id,
              userName: updated.userName,
              email: updated.email,
              mobile: updated.mobile,
              subject: updated.subject,
              message: updated.message,
              status: updated.status,
              createdAt: updated.createdAt,
              partnerId: updated.partnerId,
              partnerImage: updated.partnerImage,
              partnerDocuments: updated.partnerDocuments,
            );
          }

          tickets = List.from(_allTickets);

          notifyListeners();

          return true;
        }
      }
    } catch (e) {
      debugPrint("closeTicket : $e");
    }

    return false;
  }
  /// ===============================
  /// REFRESH
  /// ===============================

  void refreshList() {
    tickets = List.from(_allTickets);
    notifyListeners();
  }

}