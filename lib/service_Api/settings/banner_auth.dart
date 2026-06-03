import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../service_model/settings_model/banner_model.dart';

class BannerAuth extends ChangeNotifier {
  /// Base endpoint
  final String baseUrl =
      'https://adminbackend-1-h03r.onrender.com/api/settings/banners';

  /// Full list from backend
  List<BannerModel> _allBanners = [];

  /// Visible list
  List<BannerModel> banners = [];

  bool isLoading = false;
  String? errorMessage;

  /// Pagination
  int selectedEntries = 10;
  int currentPage = 1;

  /// Search text
  String _searchText = '';

  int get totalPages {
    if (banners.isEmpty) return 1;
    return (banners.length / selectedEntries).ceil();
  }

  List<BannerModel> get paginatedBanners {
    final start = (currentPage - 1) * selectedEntries;
    final end = (start + selectedEntries).clamp(0, banners.length);

    if (start >= banners.length) return [];
    return banners.sublist(start, end);
  }

  /// GET banners
  Future<void> fetchBanners() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          decoded is Map<String, dynamic> &&
          decoded['success'] == true) {
        final data = decoded['data'];

        if (data is List) {
          _allBanners = data
              .whereType<Map<String, dynamic>>()
              .map((e) => BannerModel.fromJson(e))
              .toList();

          _applyFilters();
        } else {
          errorMessage = 'Banner data format invalid hai';
        }
      } else {
        errorMessage = decoded['message'] ?? 'Banners load nahi hue';
      }
    } catch (e) {
      errorMessage = 'API error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  /// Search + page clamp
  void _applyFilters() {
    List<BannerModel> result = List.from(_allBanners);

    if (_searchText.trim().isNotEmpty) {
      final q = _searchText.toLowerCase();
      result = result.where((item) {
        return item.title.toLowerCase().contains(q);
      }).toList();
    }

    banners = result;

    if (currentPage > totalPages) currentPage = totalPages;
    if (currentPage < 1) currentPage = 1;

    notifyListeners();
  }

  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  void searchBanner(String value) {
    _searchText = value;
    currentPage = 1;
    _applyFilters();
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

  /// file type helper
  MediaType _mediaTypeFromFileName(String fileName) {
    final ext = fileName.toLowerCase().split('.').last;

    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'webp':
        return MediaType('image', 'webp');
      default:
        return MediaType('application', 'octet-stream');
    }
  }

  /// POST /api/settings/banners
  Future<void> addBanner({
    required String title,
    required Uint8List? imageBytes,
    required String? imageName,
  }) async {
    try {
      if (title.trim().isEmpty) {
        errorMessage = 'Title is required';
        notifyListeners();
        return;
      }

      if (imageBytes == null || imageName == null || imageName.isEmpty) {
        errorMessage = 'Image is required';
        notifyListeners();
        return;
      }

      final request = http.MultipartRequest('POST', Uri.parse(baseUrl));

      /// Text fields
      request.fields['title'] = title.trim();
      request.fields['status'] = 'true';

      /// File field
      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // backend field name
          imageBytes,
          filename: imageName,
          contentType: _mediaTypeFromFileName(imageName),
        ),
      );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchBanners();
      } else {
        errorMessage = decoded['message'] ?? 'Banner add nahi hua';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Add API error: $e';
      notifyListeners();
    }
  }

  /// PUT /api/settings/banners/{id}
  Future<void> updateBanner({
    required int id,
    required String title,
    required String existingImage,
    Uint8List? newImageBytes,
    String? newImageName,
  }) async {
    try {
      if (title.trim().isEmpty) {
        errorMessage = 'Title is required';
        notifyListeners();
        return;
      }

      final request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/$id'));

      /// Text field
      request.fields['title'] = title.trim();

      /// If new image selected, upload new file.
      /// Otherwise keep existing image path/url.
      if (newImageBytes != null &&
          newImageName != null &&
          newImageName.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            newImageBytes,
            filename: newImageName,
            contentType: _mediaTypeFromFileName(newImageName),
          ),
        );
      } else {
        request.fields['image'] = existingImage;
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await fetchBanners();
      } else {
        errorMessage = decoded['message'] ?? 'Banner update nahi hua';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Update API error: $e';
      notifyListeners();
    }
  }

  /// PATCH /api/settings/banners/{id}
  Future<void> toggleStatus(int id) async {
    final index = _allBanners.indexWhere((e) => e.id == id);
    if (index == -1) return;

    final newStatus = !_allBanners[index].status;

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'status': newStatus,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _allBanners[index] = _allBanners[index].copyWith(status: newStatus);
        _applyFilters();
      } else {
        errorMessage = decoded['message'] ?? 'Status update nahi hua';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Status API error: $e';
      notifyListeners();
    }
  }

  /// DELETE /api/settings/banners/{id}
  Future<void> deleteBanner(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: const {
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchBanners();
      } else {
        errorMessage = decoded['message'] ?? 'Banner delete nahi hua';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Delete API error: $e';
      notifyListeners();
    }
  }
}