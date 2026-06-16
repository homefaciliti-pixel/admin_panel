import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/App_permission/app_permission.dart';
import '../../service_Api/categories/categories_auth.dart';
import '../../service_model/category/category_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthCategories()..fetchCategories(),
      child: Consumer<AuthCategories>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(
              child: Text(
                vm.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final total = vm.categories.length;
          final safeStart = ((vm.currentPage - 1) * vm.selectedEntries).clamp(
            0,
            total,
          );
          final safeEnd = (safeStart + vm.selectedEntries).clamp(0, total);
          final pageData = vm.categories.sublist(safeStart, safeEnd);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () => _showAddDialog(context, vm),
                      icon: const Icon(Icons.add),
                      label: const Text("Add New"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<int>(
                        value: vm.selectedEntries,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(
                            value: 10,
                            child: Text("10 Entries"),
                          ),
                          DropdownMenuItem(
                            value: 20,
                            child: Text("20 Entries"),
                          ),
                          DropdownMenuItem(
                            value: 50,
                            child: Text("50 Entries"),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) vm.changeEntries(value);
                        },
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 220,
                      child: TextField(
                        onChanged: vm.searchCategory,
                        decoration: InputDecoration(
                          hintText: "Search",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(14),
                  color: Colors.blue.shade50,
                  child: const Row(
                    children: [
                      Expanded(flex: 1, child: Text("#")),
                      Expanded(flex: 4, child: Text("Title")),
                      Expanded(flex: 2, child: Text("Parent")),
                      Expanded(flex: 2, child: Text("Image")),
                      Expanded(flex: 2, child: Text("Status")),
                      Expanded(flex: 2, child: Text("Action")),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: pageData.length,
                    itemBuilder: (context, index) {
                      final item = pageData[index];

                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Text("${item.id}")),
                            Expanded(flex: 4, child: Text(item.title)),
                            Expanded(
                              flex: 2,
                              child: Text(
                                item.parent.isEmpty
                                    ? 'Main Category'
                                    : item.parent,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: _buildNetworkImage(item.image),
                            ),
                            Expanded(
                              flex: 2,
                              child: AppPermission.isSuperAdmin
                                  ? Switch(
                                      value: item.status,
                                      onChanged: (v) async {
                                        await vm.toggleStatus(item.id, v);
                                      },
                                    )
                                  : Text(item.status ? "Active" : "Inactive"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        _showEditDialog(context, vm, item),
                                    icon: const Icon(Icons.edit),
                                  ),
                                  if (AppPermission.isSuperAdmin)
                                    IconButton(
                                      onPressed: () async {
                                        await vm.deleteCategory(item.id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: vm.previousPage,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Text(
                      "Page ${vm.currentPage} / ${vm.totalPages}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: vm.nextPage,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context, AuthCategories vm) {
    final titleController = TextEditingController();
    String? selectedParent = 'Main Category';
    Uint8List? imageBytes;
    XFile? pickedFile;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add Category"),
              content: SizedBox(
                width: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Category Name",
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String?>(
                      value: selectedParent,
                      decoration: const InputDecoration(
                        labelText: "Parent Category",
                      ),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: 'Main Category',
                          child: Text("Main Category"),
                        ),
                        ...vm.parentOptions.map(
                          (p) => DropdownMenuItem<String?>(
                            value: p,
                            child: Text(p),
                          ),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          selectedParent = v ?? 'Main Category';
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final file = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 85,
                        );

                        if (file != null) {
                          final bytes = await file.readAsBytes();
                          setState(() {
                            pickedFile = file;
                            imageBytes = bytes;
                          });
                        }
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("Pick Image"),
                    ),
                    const SizedBox(height: 10),
                    _buildPreview(bytes: imageBytes),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await vm.addCategory(
                      title: titleController.text.trim(),
                      parent: selectedParent,
                      imageBytes: imageBytes,
                      imageName: pickedFile?.name,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditDialog(
    BuildContext context,
    AuthCategories vm,
    CategoryItem item,
  ) {
    final titleController = TextEditingController(text: item.title);
    String? selectedParent = item.parent.trim().isEmpty
        ? 'Main Category'
        : item.parent.trim();

    String existingImage = item.image;
    Uint8List? imageBytes;
    XFile? pickedFile;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit Category"),
              content: SizedBox(
                width: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Category Name",
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String?>(
                      value: selectedParent,
                      decoration: const InputDecoration(
                        labelText: "Parent Category",
                      ),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: 'Main Category',
                          child: Text("Main Category"),
                        ),
                        ...vm.parentOptions.map(
                          (p) => DropdownMenuItem<String?>(
                            value: p,
                            child: Text(p),
                          ),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          selectedParent = v ?? 'Main Category';
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final file = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 85,
                        );

                        if (file != null) {
                          final bytes = await file.readAsBytes();
                          setState(() {
                            pickedFile = file;
                            imageBytes = bytes;
                          });
                        }
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("Change Image"),
                    ),
                    const SizedBox(height: 10),
                    _buildPreview(
                      bytes: imageBytes,
                      existingImage: existingImage,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await vm.updateCategory(
                      id: item.id,
                      title: titleController.text.trim(),
                      parent: selectedParent,
                      existingImage: existingImage,
                      newImageBytes: imageBytes,
                      newImageName: pickedFile?.name,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static String _normalizeUrl(String url) {
    if (url.startsWith('http://') &&
        !url.contains('localhost') &&
        !url.contains('127.0.0.1') &&
        !url.contains('10.0.2.2')) {
      return url.replaceFirst('http://', 'https://');
    }
    return url;
  }

  static const String imageBaseUrl =
      "https://adminbackend-1-h03r.onrender.com/uploads/";

  static Widget _buildNetworkImage(String path, {double size = 45}) {
    if (path.isEmpty) {
      return _emptyImageBox(size);
    }

    final rawUrl = path.startsWith('http') ? path : '$imageBaseUrl$path';
    final imageUrl = _normalizeUrl(rawUrl);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _emptyImageBox(size);
        },
      ),
    );
  }

  static Widget _buildPreview({
    Uint8List? bytes,
    String existingImage = '',
    double size = 80,
  }) {
    if (bytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          bytes,
          height: size,
          width: size,
          fit: BoxFit.cover,
        ),
      );
    }

    if (existingImage.isNotEmpty) {
      final rawUrl = existingImage.startsWith('http')
          ? existingImage
          : '$imageBaseUrl$existingImage';
      final imageUrl = _normalizeUrl(rawUrl);

      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          height: size,
          width: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _emptyImageBox(size),
        ),
      );
    }

    return _emptyImageBox(size);
  }

  static Widget _emptyImageBox(double size) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'No image',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
