import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../data/models/service_model.dart';
import '../data/services/api_service.dart';

class ServiceViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool isLoading = false;

  /// =========================================
  /// PAGINATION
  /// =========================================

  /// table me kitni entries show hongi
  int selectedEntries = 10;

  /// current page number
  int currentPage = 1;

  /// =========================================
  /// MASTER SERVICE LIST
  /// =========================================
  ///
  /// ye original data hai
  /// future me yaha API ka data aayega

  final List<ServiceModel> _allServices = [];

  /// =========================================
  /// VISIBLE LIST
  /// =========================================
  ///
  /// screen pe ye data show hoga
  /// search/filter ke baad ye update hota hai

  List<ServiceModel> services = [];

  /// =========================================
  /// CONSTRUCTOR
  /// =========================================
  ///
  /// screen open hote hi data load karega

  ServiceViewModel() {
    loadServices();
  }

  Future<void> loadServices() async {
    isLoading = true;
    notifyListeners();

    final apiData = await _api.getServices();
    _allServices.clear();
    _allServices.addAll(apiData);
    services = List.from(_allServices);

    isLoading = false;
    notifyListeners();
  }

  /// =========================================
  /// TOTAL PAGES
  /// =========================================

  int get totalPages {

    if (services.isEmpty) {
      return 1;
    }

    return
      (services.length / selectedEntries)
          .ceil();
  }

  /// =========================================
  /// PAGINATED DATA
  /// =========================================
  ///
  /// current page ke hisab se
  /// table me limited data show karega

  List<ServiceModel> get paginatedServices {

    final start =
        (currentPage - 1) *
            selectedEntries;

    int end =
        start + selectedEntries;

    if (end > services.length) {

      end = services.length;
    }

    if (start >= services.length) {

      return [];
    }

    return services.sublist(
      start,
      end,
    );
  }

  /// =========================================
  /// CHANGE ENTRIES
  /// =========================================
  ///
  /// show 10 / 20 / 50 / 100

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
  /// SEARCH SERVICE
  /// =========================================
  ///
  /// title + description pe search

  void searchService(String value) {

    if (value.trim().isEmpty) {

      services =
          List.from(_allServices);

    } else {

      final keyword =
      value.toLowerCase();

      services =
          _allServices.where((item) {

            return
              item.title
                  .toLowerCase()
                  .contains(keyword)

                  ||

                  item.description
                      .toLowerCase()
                      .contains(keyword);

          }).toList();
    }

    /// search ke baad page reset
    currentPage = 1;

    notifyListeners();
  }

  /// =========================================
  /// DELETE SERVICE
  /// =========================================
  ///
  /// list se remove karega

  Future<void> deleteService(int id) async {
    final success = await _api.deleteService(id);
    if (success) {
      _allServices.removeWhere(
            (e) => e.id == id,
      );

      services =
          List.from(_allServices);

      /// agar last item delete hua
      /// to page auto adjust hoga

      if (currentPage > totalPages) {
        currentPage = totalPages;
      }

      notifyListeners();
    }
  }

  /// =========================================
  /// TOGGLE STATUS
  /// =========================================
  ///
  /// active <-> inactive

  Future<void> toggleStatus(int id) async {
    final index = _allServices.indexWhere((e) => e.id == id);
    if (index != -1) {
      final item = _allServices[index];
      final success = await _api.toggleServiceStatus(id, !item.status);
      if (success) {
        _allServices[index].status = !item.status;
        services = List.from(_allServices);
        notifyListeners();
      }
    }
  }

  /// toggle isHighlighted (service highlight/feature)
  Future<void> toggleHighlight(int id) async {
    final index = _allServices.indexWhere((e) => e.id == id);
    if (index != -1) {
      final item = _allServices[index];
      final newHighlight = item.isHighlighted.isEmpty ? "Featured" : "";
      final success = await _api.toggleServiceHighlight(id, newHighlight);
      if (success) {
        _allServices[index].isHighlighted = newHighlight;
        services = List.from(_allServices);
        notifyListeners();
      }
    }
  }

  /// =========================================
  /// ADD NEW SERVICE
  /// =========================================
  ///
  /// future me yahi API hit karega
  
  Future<void> addService({
    required String title,
    required double price,
    double discount = 0.0,
    required String image,
    Uint8List? imageBytes,
    required String description,
    String isHighlighted = "",
    int? categoryId,
    double? rating,
    String? time,
  }) async {
    String imageUrl = image;
    if (imageBytes != null) {
      final filename = image.isNotEmpty ? image.split('/').last.split('\\').last : 'service_image.png';
      final uploadedUrl = await _api.uploadImage(imageBytes, filename);
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      }
    }
    final newService = await _api.addService(
      title, price, imageUrl, description, true,
      discount: discount,
      isHighlighted: isHighlighted,
      categoryId: categoryId,
      rating: rating,
      time: time,
    );
    if (newService != null) {
      _allServices.add(newService);
      services = List.from(_allServices);
      notifyListeners();
    }
  }

  /// update an existing service
  Future<void> updateService(int id, {
    String? title,
    double? price,
    double? discount,
    String? image,
    Uint8List? imageBytes,
    String? description,
    bool? status,
    String? isHighlighted,
    int? categoryId,
    double? rating,
    String? time,
  }) async {
    String? imageUrl = image;
    if (imageBytes != null) {
      final filename = (image != null && image.isNotEmpty) ? image.split('/').last.split('\\').last : 'service_image.png';
      final uploadedUrl = await _api.uploadImage(imageBytes, filename);
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      }
    }
    final updated = await _api.updateService(id,
      title: title,
      price: price,
      discount: discount,
      image: imageUrl,
      description: description,
      status: status,
      isHighlighted: isHighlighted,
      categoryId: categoryId,
      rating: rating,
      time: time,
    );
    if (updated != null) {
      final index = _allServices.indexWhere((e) => e.id == id);
      if (index != -1) {
        _allServices[index] = updated;
        services = List.from(_allServices);
        notifyListeners();
      }
    }
  }
}