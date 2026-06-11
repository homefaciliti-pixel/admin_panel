import 'package:flutter/material.dart';
import '../data/models/page_model.dart';
import '../data/services/api_service.dart';

class PageViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  /// original list
  final List<PageModel> _allPages = [];

  /// visible list
  List<PageModel> pages = [];

  /// constructor
  PageViewModel() {
    loadPages();
  }

  Future<void> loadPages() async {
    isLoading = true;
    notifyListeners();

    final list = await _api.getPages();
    _allPages.clear();
    _allPages.addAll(list);
    pages = List.from(_allPages);

    isLoading = false;
    notifyListeners();
  }

  /// =====================================
  /// UPDATE PAGE
  /// =====================================
  ///
  /// title + description edit karega
  Future<void> updatePage({
    required int id,
    required String title,
    required String description,
  }) async {
    final updated = await _api.updatePage(id, title, description);
    if (updated != null) {
      final index = _allPages.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allPages[index] = updated;
        pages = List.from(_allPages);
        notifyListeners();
      }
    }
  }
}