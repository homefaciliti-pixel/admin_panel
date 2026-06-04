import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../data/models/category_model.dart';
import '../../service_model/category/category_model.dart';

class AuthCategories extends ChangeNotifier {
  final String baseUrl = 'https://adminbackend-1-h03r.onrender.com/api';
  final String uploadUrl = 'https://adminbackend-1-h03r.onrender.com/api/upload';

  List<CategoryItem> _allCategories = [];
  List<CategoryItem> categories = [];

  bool isLoading = false;
  String? errorMessage;

  int currentPage = 1;
  int selectedEntries = 10;
  String _searchText = '';

  List<String> get parentOptions {
    final set = <String>{};
    for (final item in _allCategories) {
      final p = item.parent.trim();
      if (p.isNotEmpty && p.toLowerCase() != 'main category') {
        set.add(p);
      }
    }
    return set.toList()..sort();
  }

  int get totalPages {
    if (categories.isEmpty) return 1;
    return (categories.length / selectedEntries).ceil();
  }

  Future<void> fetchCategories() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: const {'Content-Type': 'application/json'},
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        final List data = body['data'] ?? [];

        _allCategories = data
            .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
            .toList();

        _applyFilters();
      } else {
        errorMessage = body['message'] ?? 'Categories load nahi ho payi';
      }
    } catch (e) {
      errorMessage = 'API error: $e';
    }

    isLoading = false;
    notifyListeners();
  }

  void _applyFilters() {
    List<CategoryItem> result = List.from(_allCategories);

    if (_searchText.trim().isNotEmpty) {
      final q = _searchText.toLowerCase();
      result = result.where((item) {
        return item.title.toLowerCase().contains(q) ||
            item.parent.toLowerCase().contains(q) ||
            item.image.toLowerCase().contains(q);
      }).toList();
    }

    categories = result;

    if (currentPage > totalPages) currentPage = totalPages;
    if (currentPage < 1) currentPage = 1;

    notifyListeners();
  }

  void changeEntries(int value) {
    selectedEntries = value;
    currentPage = 1;
    notifyListeners();
  }

  void searchCategory(String value) {
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

  MediaType? _mediaTypeFromFileName(String fileName) {
    final ext = fileName.toLowerCase().split('.').last;

    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      case 'webp':
        return MediaType('image', 'webp');
      default:
        return null;
    }
  }

  Future<String?> _uploadImage(Uint8List bytes, String fileName) async {
    final mediaType = _mediaTypeFromFileName(fileName);

    if (mediaType == null) {
      throw Exception('Only image files (jpg, jpeg, png, gif, webp) are allowed!');
    }

    final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: fileName,
        contentType: mediaType,
      ),
    );

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (body is Map<String, dynamic>) {
        if (body['data'] is Map<String, dynamic>) {
          final data = body['data'] as Map<String, dynamic>;
          return data['image']?.toString() ??
              data['filename']?.toString() ??
              data['path']?.toString();
        }

        return body['image']?.toString() ??
            body['filename']?.toString() ??
            body['path']?.toString();
      }
    }

    throw Exception(body['message'] ?? 'Image upload failed');
  }

  Future<void> addCategory({
    required String title,
    String? parent,
    required Uint8List? imageBytes,
    required String? imageName,
  }) async {
    try {
      String finalImage = '';

      if (imageBytes != null && imageName != null && imageName.isNotEmpty) {
        final uploaded = await _uploadImage(imageBytes, imageName);
        finalImage = uploaded ?? '';
      }

      final response = await http.post(
        Uri.parse('$baseUrl/categories'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title.trim(),
          'parent': (parent == null || parent.trim().isEmpty)
              ? 'Main Category'
              : parent.trim(),
          'image': finalImage,
          'status': true,
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchCategories();
      } else {
        errorMessage = body['message'] ?? 'Category add nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Add API error: $e';
      notifyListeners();
    }
  }

  Future<void> updateCategory({
    required int id,
    required String title,
    String? parent,
    required String existingImage,
    Uint8List? newImageBytes,
    String? newImageName,
  }) async {
    try {
      String finalImage = existingImage;

      if (newImageBytes != null && newImageName != null && newImageName.isNotEmpty) {
        final uploaded = await _uploadImage(newImageBytes, newImageName);
        if (uploaded != null && uploaded.isNotEmpty) {
          finalImage = uploaded;
        }
      }

      final response = await http.put(
        Uri.parse('$baseUrl/categories/$id'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title.trim(),
          'parent': (parent == null || parent.trim().isEmpty)
              ? 'Main Category'
              : parent.trim(),
          'image': finalImage,
        }),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await fetchCategories();
      } else {
        errorMessage = body['message'] ?? 'Category update nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Update API error: $e';
      notifyListeners();
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/categories/$id'),
        headers: const {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchCategories();
      } else {
        errorMessage = 'Category delete nahi hui';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'Delete API error: $e';
      notifyListeners();
    }
  }

  Future<void> toggleStatus(int id, bool value) async {
    final index = _allCategories.indexWhere((e) => e.id == id);
    if (index == -1) return;

    final item = _allCategories[index];

    _allCategories[index] = item.copyWith(status: value);
    _applyFilters();

    try {
      await http.put(
        Uri.parse('$baseUrl/categories/$id'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': item.title,
          'parent': item.parent,
          'image': item.image,
          'status': value,
        }),
      );
    } catch (_) {}
  }
}