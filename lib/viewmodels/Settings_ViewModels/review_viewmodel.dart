import 'package:flutter/material.dart';
import '../../data/models/Settings models/review_model.dart';

class ReviewViewModel extends ChangeNotifier {
  /// =========================================
  /// PAGINATION
  /// =========================================

  /// table me kitni entries dikhani hain
  int selectedEntries = 10;

  /// current page number
  int currentPage = 1;

  /// =========================================
  /// MASTER LIST
  /// =========================================
  ///
  /// future me yaha API se data aayega
  /// abhi dummy data use kar rahe hain

  final List<ReviewModel> _allReviews = [
    ReviewModel(
      id: 1,
      userName: "Rahul Sharma",
      partnerName: "Govind",
      serviceName: "AC Repair",
      rating: 4.5,
      reviewText: "Service was quick and professional.",
      status: true,
    ),
    ReviewModel(
      id: 2,
      userName: "Neha Singh",
      partnerName: "Mahesh Kumar",
      serviceName: "Plumbing",
      rating: 5.0,
      reviewText: "Very good work and polite behavior.",
      status: true,
    ),
    ReviewModel(
      id: 3,
      userName: "Aman Verma",
      partnerName: "Sonali",
      serviceName: "Electrician",
      rating: 3.5,
      reviewText: "Work completed, but delay was there.",
      status: false,
    ),
  ];

  /// screen pe jo reviews dikhne hain
  List<ReviewModel> reviews = [];

  /// constructor
  ReviewViewModel() {
    reviews = List.from(_allReviews);
  }

  /// =========================================
  /// ALL REVIEWS
  /// =========================================
  ///
  /// agar kisi aur screen ko full list chahiye ho

  List<ReviewModel> get allReviews => List.from(_allReviews);

  /// =========================================
  /// TOTAL PAGES
  /// =========================================

  int get totalPages {
    if (reviews.isEmpty) return 1;
    return (reviews.length / selectedEntries).ceil();
  }

  /// =========================================
  /// PAGINATED DATA
  /// =========================================

  List<ReviewModel> get paginatedReviews {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (end > reviews.length) {
      end = reviews.length;
    }

    if (start >= reviews.length) {
      return [];
    }

    return reviews.sublist(start, end);
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
  /// SEARCH REVIEW
  /// =========================================
  ///
  /// user, partner, service, review text pe search

  void searchReview(String value) {
    if (value.trim().isEmpty) {
      reviews = List.from(_allReviews);
    } else {
      final keyword = value.toLowerCase();

      reviews = _allReviews.where((item) {
        return item.userName.toLowerCase().contains(keyword) ||
            item.partnerName.toLowerCase().contains(keyword) ||
            item.serviceName.toLowerCase().contains(keyword) ||
            item.reviewText.toLowerCase().contains(keyword) ||
            item.rating.toString().contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  /// =========================================
  /// TOGGLE STATUS
  /// =========================================
  ///
  /// approved / hidden

  void toggleStatus(int id) {
    final index = _allReviews.indexWhere((e) => e.id == id);

    if (index != -1) {
      _allReviews[index] = _allReviews[index].copyWith(
        status: !_allReviews[index].status,
      );

      reviews = List.from(_allReviews);
      notifyListeners();
    }
  }

  /// =========================================
  /// DELETE REVIEW
  /// =========================================

  void deleteReview(int id) {
    _allReviews.removeWhere((e) => e.id == id);
    reviews = List.from(_allReviews);

    if (currentPage > totalPages) {
      currentPage = totalPages;
    }

    notifyListeners();
  }

  /// =========================================
  /// ADD REVIEW
  /// =========================================
  ///
  /// future API/testing ke kaam aa sakta hai

  void addReview({
    required String userName,
    required String partnerName,
    required String serviceName,
    required double rating,
    required String reviewText,
  }) {
    final newReview = ReviewModel(
      id: _allReviews.isEmpty ? 1 : _allReviews.last.id + 1,
      userName: userName,
      partnerName: partnerName,
      serviceName: serviceName,
      rating: rating,
      reviewText: reviewText,
      status: true,
    );

    _allReviews.add(newReview);
    reviews = List.from(_allReviews);
    notifyListeners();
  }





  /// =========================================
  /// UPDATE REVIEW
  /// =========================================
  ///
  /// edit dialog se updated values save karega

  void updateReview({
    required int id,
    required String userName,
    required String partnerName,
    required String serviceName,
    required double rating,
    required String reviewText,
  }) {
    final index = _allReviews.indexWhere((e) => e.id == id);

    if (index != -1) {
      _allReviews[index] = _allReviews[index].copyWith(
        userName: userName,
        partnerName: partnerName,
        serviceName: serviceName,
        rating: rating,
        reviewText: reviewText,
      );

      reviews = List.from(_allReviews);
      notifyListeners();
    }
  }

}


