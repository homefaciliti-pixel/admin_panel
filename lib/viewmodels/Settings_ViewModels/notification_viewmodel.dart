import 'package:flutter/material.dart';
import '../../data/models/Settings models/notification_model.dart';


class NotificationViewModel extends ChangeNotifier {

  /// =========================================
  /// PAGINATION
  /// =========================================

  /// table me kitni entries show hongi
  int selectedEntries = 10;

  /// current page
  int currentPage = 1;

  /// =========================================
  /// MASTER LIST
  /// =========================================
  ///
  /// future me backend/API se aayega

  final List<NotificationModel> _allNotifications = [

    NotificationModel(

      id: 1,

      title: "Festival Offer",

      message:
      "Get 20% discount on all AC services.",

      audience: "All Users",

      createdAt: "2026-05-19",

      status: true,
    ),

    NotificationModel(

      id: 2,

      title: "Partner Meeting",

      message:
      "Monthly partner meeting scheduled tomorrow.",

      audience: "All Partners",

      createdAt: "2026-05-18",

      status: true,
    ),

    NotificationModel(

      id: 3,

      title: "Maintenance Notice",

      message:
      "System maintenance from 2 AM to 4 AM.",

      audience: "All Users",

      createdAt: "2026-05-17",

      status: false,
    ),
  ];

  /// UI list
  ///
  /// search/filter ke baad yahi list show hogi

  List<NotificationModel> notifications = [];

  /// constructor
  NotificationViewModel() {

    notifications =
        List.from(_allNotifications);
  }

  /// =========================================
  /// ALL NOTIFICATIONS
  /// =========================================

  List<NotificationModel> get allNotifications =>
      List.from(_allNotifications);

  /// =========================================
  /// TOTAL PAGES
  /// =========================================

  int get totalPages {

    if (notifications.isEmpty) return 1;

    return
      (notifications.length / selectedEntries)
          .ceil();
  }

  /// =========================================
  /// PAGINATED DATA
  /// =========================================

  List<NotificationModel>
  get paginatedNotifications {

    final start =
        (currentPage - 1) * selectedEntries;

    int end =
        start + selectedEntries;

    if (end > notifications.length) {
      end = notifications.length;
    }

    if (start >= notifications.length) {
      return [];
    }

    return notifications.sublist(start, end);
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
  /// SEARCH NOTIFICATION
  /// =========================================
  ///
  /// title + message + audience pe search

  void searchNotification(String value) {

    if (value.trim().isEmpty) {

      notifications =
          List.from(_allNotifications);

    } else {

      final keyword =
      value.toLowerCase();

      notifications =
          _allNotifications.where((item) {

            return item.title
                .toLowerCase()
                .contains(keyword)

                ||

                item.message
                    .toLowerCase()
                    .contains(keyword)

                ||

                item.audience
                    .toLowerCase()
                    .contains(keyword);

          }).toList();
    }

    currentPage = 1;

    notifyListeners();
  }

  /// =========================================
  /// TOGGLE STATUS
  /// =========================================

  void toggleStatus(int id) {

    final index =
    _allNotifications.indexWhere(
          (e) => e.id == id,
    );

    if (index != -1) {

      _allNotifications[index] =
          _allNotifications[index].copyWith(

            status:
            !_allNotifications[index].status,
          );

      notifications =
          List.from(_allNotifications);

      notifyListeners();
    }
  }

  /// =========================================
  /// ADD NOTIFICATION
  /// =========================================

  void addNotification({

    required String title,

    required String message,

    required String audience,
  }) {

    final newNotification =
    NotificationModel(

      id: _allNotifications.isEmpty
          ? 1
          : _allNotifications.last.id + 1,

      title: title,

      message: message,

      audience: audience,

      createdAt:
      DateTime.now()
          .toString()
          .split(" ")
          .first,

      status: true,
    );

    _allNotifications.add(
      newNotification,
    );

    notifications =
        List.from(_allNotifications);

    notifyListeners();
  }

  /// =========================================
  /// UPDATE NOTIFICATION
  /// =========================================

  void updateNotification({

    required int id,

    required String title,

    required String message,

    required String audience,
  }) {

    final index =
    _allNotifications.indexWhere(
          (e) => e.id == id,
    );

    if (index != -1) {

      _allNotifications[index] =
          _allNotifications[index].copyWith(

            title: title,

            message: message,

            audience: audience,
          );

      notifications =
          List.from(_allNotifications);

      notifyListeners();
    }
  }

  /// =========================================
  /// DELETE NOTIFICATION
  /// =========================================

  void deleteNotification(int id) {

    _allNotifications.removeWhere(
          (e) => e.id == id,
    );

    notifications =
        List.from(_allNotifications);

    if (currentPage > totalPages) {

      currentPage = totalPages;
    }

    notifyListeners();
  }


  /// =========================================
  /// SEND NOTIFICATION
  /// =========================================
  ///
  /// future me yahi backend / FCM trigger karega

  void sendNotification(int id) {
    final index = _allNotifications.indexWhere((e) => e.id == id);

    if (index != -1) {
      _allNotifications[index] = _allNotifications[index].copyWith(
        isSent: true,
        sentAt: DateTime.now().toString().split(".").first,
      );

      notifications = List.from(_allNotifications);
      notifyListeners();
    }
  }

}