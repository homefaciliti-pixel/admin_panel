import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../service_model/service_model/service_model.dart';

class ServiceAuth extends ChangeNotifier {
  ServiceAuth() {
    services = List.from(_allServices);
  }

  final String _baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api/services';

  int selectedEntries = 10;
  int currentPage = 1;

  bool isLoading = false;
  String? errorMessage;

  final List<ServiceModel> _allServices = [];
  List<ServiceModel> services = [];

  // Existing helper: if you still want to calculate final price from discount %
  double calculateDiscountPrice(double price, double discountPercent) {
    final discounted = price - (price * discountPercent / 100);
    return discounted < 0 ? 0 : discounted;
  }

  // New helper: cutPrice-based discount %
  double _calculateDiscountPercentFromCutPrice(
      double price,
      double cutPrice,
      ) {
    if (cutPrice <= 0) return 0;
    final percent = ((cutPrice - price) / cutPrice) * 100;
    if (percent.isNaN || percent.isInfinite || percent < 0) return 0;
    return percent;
  }

  int get totalPages {
    if (services.isEmpty) return 1;
    return (services.length / selectedEntries).ceil();
  }

  List<ServiceModel> get paginatedServices {
    final start = (currentPage - 1) * selectedEntries;
    int end = start + selectedEntries;

    if (start >= services.length) return [];
    if (end > services.length) end = services.length;

    return services.sublist(start, end);
  }

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

  Future<void> fetchServices() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        final List<dynamic> dataList = decoded is Map<String, dynamic>
            ? (decoded['data'] as List<dynamic>? ?? <dynamic>[])
            : <dynamic>[];

        _allServices
          ..clear()
          ..addAll(
            dataList.map(
                  (e) => ServiceModel.fromJson(e as Map<String, dynamic>),
            ),
          );

        services = List.from(_allServices);

        if (currentPage > totalPages) {
          currentPage = totalPages;
        }
      } else {
        errorMessage = response.body;
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void searchService(String value) {
    if (value.trim().isEmpty) {
      services = List.from(_allServices);
    } else {
      final keyword = value.toLowerCase();
      services = _allServices.where((item) {
        return item.title.toLowerCase().contains(keyword) ||
            item.description.toLowerCase().contains(keyword) ||
            (item.time ?? '').toLowerCase().contains(keyword) ||
            (item.categoryId?.toString() ?? '').contains(keyword);
      }).toList();
    }

    currentPage = 1;
    notifyListeners();
  }

  Future<bool> deleteService(int id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchServices();
        return true;
      }

      errorMessage = response.body;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleStatus(int id, bool currentStatus) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl/$id/status'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'status': !currentStatus,
        }),
      );

      if (response.statusCode == 200) {
        await fetchServices();
        return true;
      }

      errorMessage = response.body;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addService({
    required String title,
    required String? categoryId,
    required double price,
    required double cutPrice,
    required double discountPercent,
    required List<int>? imageBytes,
    required String description,
    required List<String> highlights,
    required double rating,
    required int reviewsCount,
    required String serviceTime,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final uploadedImageUrl = await _uploadImageToServer(imageBytes);

      final body = {
        'title': title.trim(),
        'price': price,
        'cutPrice': cutPrice,
        'discount': discountPercent,
        'image': uploadedImageUrl ?? '',
        'description': description.trim(),
        'status': true,
        'category_id': categoryId,
        'rating': rating,
        'time': serviceTime.trim(),
        'isHighlighted': highlights.isNotEmpty,
        'categoryId': categoryId,
        'highlights': highlights,
      };

      print('POST BODY => ${jsonEncode(body)}');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('POST STATUS => ${response.statusCode}');
      print('POST RESPONSE => ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchServices();
        return true;
      }

      errorMessage = response.body;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateService({
    required int id,
    required String title,
    required String? categoryId,
    required double price,
    required double cutPrice,
    required double discountPercent,
    required List<int>? imageBytes,
    required String description,
    required List<String> highlights,
    required double rating,
    required int reviewsCount,
    required String serviceTime,
    String? existingImageUrl,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final uploadedImageUrl = await _uploadImageToServer(imageBytes);
      final finalImageUrl = uploadedImageUrl ?? existingImageUrl ?? '';

      final body = {
        'id': id,
        'title': title.trim(),
        'price': price,
        'cutPrice': cutPrice,
        'discount': discountPercent,
        'image': finalImageUrl,
        'description': description.trim(),
        'status': false,
        'category_id': categoryId,
        'rating': rating,
        'time': serviceTime.trim(),
        'isHighlighted': highlights.isNotEmpty,
        'categoryId': categoryId,
        'highlights': highlights,
      };

      print('PUT BODY => ${jsonEncode(body)}');

      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('PUT STATUS => ${response.statusCode}');
      print('PUT RESPONSE => ${response.body}');

      if (response.statusCode == 200) {
        await fetchServices();
        return true;
      }

      errorMessage = response.body;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }





  Future<String?> _uploadImageToServer(List<int>? imageBytes) async {
    if (imageBytes == null || imageBytes.isEmpty) return null;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://adminbackend-1-h03r.onrender.com/api/upload'),
      );

      // If backend field name is different, change only 'image'
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'service_image.jpg',
        ),
      );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return json['data']?['url']?.toString();
      }

      debugPrint('Image upload failed: ${response.body}');
      return null;
    } catch (e) {
      debugPrint('Image upload error: $e');
      return null;
    }
  }

}