import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../data/models/category_model.dart';
import '../data/services/api_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  /// entries per page
  int selectedEntries = 10;

  /// current page
  int currentPage = 1;

  /// visible list
  List<CategoryModel> categories = [];

  /// original list
  final List<CategoryModel> _allCategories = [];

  CategoryViewModel() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();

    final list = await _api.getCategories();
    _allCategories.clear();
    _allCategories.addAll(list);
    categories = List.from(_allCategories);

    isLoading = false;
    notifyListeners();
  }

  /// total pages
  int get totalPages {
    if (categories.isEmpty) return 1;
    return (categories.length / selectedEntries).ceil();
  }

  /// change dropdown entries
  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  /// next page
  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      notifyListeners();
    }
  }

  /// previous page
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  /// direct page
  void goToPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  /// search category
  void searchCategory(String value) {
    if (value.trim().isEmpty) {
      categories = List.from(_allCategories);
    } else {
      final keyword = value.toLowerCase();
      categories = _allCategories.where((item) {
        return item.title.toLowerCase().contains(keyword) ||
            item.parent.toLowerCase().contains(keyword);
      }).toList();
    }
    currentPage = 1;
    notifyListeners();
  }

  /// toggle status by ID (paginated index se item ka ID leke toggle karo)
  Future<void> toggleStatus(int index, bool value) async {
    final cat = categories[index];
    final success = await _api.toggleCategoryStatus(cat.id, value);
    if (success) {
      categories[index].status = value;
      final mainIndex = _allCategories.indexWhere((e) => e.id == cat.id);
      if (mainIndex != -1) {
        _allCategories[mainIndex].status = value;
      }
      notifyListeners();
    }
  }

  /// toggle status by category ID directly
  Future<void> toggleStatusById(int id, bool value) async {
    final success = await _api.toggleCategoryStatus(id, value);
    if (success) {
      final index = categories.indexWhere((e) => e.id == id);
      if (index != -1) categories[index].status = value;
      final mainIndex = _allCategories.indexWhere((e) => e.id == id);
      if (mainIndex != -1) _allCategories[mainIndex].status = value;
      notifyListeners();
    }
  }

  /// add category
  Future<void> addCategory(
    String title,
    String parent,
    String image,
    Uint8List? imageBytes,
  ) async {
    String imageUrl = image;
    if (imageBytes != null) {
      final filename = image.isNotEmpty ? image.split('/').last.split('\\').last : 'category_image.png';
      final uploadedUrl = await _api.uploadImage(imageBytes, filename);
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      }
    }
    final newCat = await _api.addCategory(title, parent, imageUrl, true);
    if (newCat != null) {
      _allCategories.add(newCat);
      categories = List.from(_allCategories);
      notifyListeners();
    }
  }

  /// delete category
  Future<void> deleteCategory(int id) async {
    final success = await _api.deleteCategory(id);
    if (success) {
      _allCategories.removeWhere((e) => e.id == id);
      categories = List.from(_allCategories);

      if (currentPage > totalPages) {
        currentPage = totalPages;
      }
      notifyListeners();
    }
  }

  /// update category
  Future<void> updateCategory(
    int id,
    String title,
    String parent,
    String image,
    Uint8List? imageBytes,
  ) async {
    String imageUrl = image;
    if (imageBytes != null) {
      final filename = image.isNotEmpty ? image.split('/').last.split('\\').last : 'category_image.png';
      final uploadedUrl = await _api.uploadImage(imageBytes, filename);
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      }
    }
    final updated = await _api.updateCategory(id, title: title, parent: parent, image: imageUrl);
    if (updated != null) {
      final index = _allCategories.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allCategories[index] = updated;
      }
      categories = List.from(_allCategories);
      notifyListeners();
    }
  }
}