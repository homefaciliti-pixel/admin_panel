import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../service_Api/settings/banner_auth.dart';
import '../../service_model/settings_model/banner_model.dart';


class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// Screen open hote hi banners fetch
      create: (_) => BannerAuth()..fetchBanners(),
      child: Consumer<BannerAuth>(
        builder: (context, vm, child) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PAGE HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Banner",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Home > Settings > Banner",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _showAddDialog(context, vm);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff111827),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text("Add New"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// SHOW ENTRIES + SEARCH
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Show",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: DropdownButton<int>(
                              value: vm.selectedEntries,
                              underline: const SizedBox(),
                              items: [10, 20, 50, 100].map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text("$e"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  vm.changeEntries(value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("entries"),
                        ],
                      ),
                      SizedBox(
                        width: 260,
                        child: TextField(
                          onChanged: vm.searchBanner,
                          decoration: InputDecoration(
                            hintText: "Search Banner",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// TABLE
                if (vm.isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (vm.errorMessage != null)
                  Expanded(
                    child: Center(
                      child: Text(
                        vm.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 1200,
                            child: Column(
                              children: [
                                /// TABLE HEADER
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  color: Colors.blue.shade50,
                                  child: const Row(
                                    children: [
                                      Expanded(flex: 1, child: Text("ID")),
                                      Expanded(flex: 3, child: Text("TITLE")),
                                      Expanded(flex: 3, child: Text("IMAGE")),
                                      Expanded(flex: 2, child: Text("STATUS")),
                                      Expanded(flex: 2, child: Text("ACTION")),
                                    ],
                                  ),
                                ),

                                /// TABLE BODY
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: vm.paginatedBanners.length,
                                    itemBuilder: (context, index) {
                                      final item = vm.paginatedBanners[index];

                                      return Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(item.id.toString()),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                item.title,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Container(
                                                  height: 55,
                                                  width: 120,
                                                  color: Colors.grey.shade100,
                                                  child: _bannerImage(item.image),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Switch(
                                                value: item.status,
                                                onChanged: (value) {
                                                  vm.toggleStatus(item.id);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    tooltip: "Edit",
                                                    icon: const Icon(Icons.edit),
                                                    onPressed: () {
                                                      _showEditDialog(
                                                        context,
                                                        vm,
                                                        item,
                                                      );
                                                    },
                                                  ),
                                                  IconButton(
                                                    tooltip: "Delete",
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      _showDeleteDialog(
                                                        context,
                                                        vm,
                                                        item,
                                                      );
                                                    },
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                /// PAGINATION
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Page",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff111827),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${vm.currentPage}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "/ ${vm.totalPages}",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: vm.previousPage,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: const Icon(Icons.chevron_left),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: vm.nextPage,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: const Icon(Icons.chevron_right),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Banner image renderer
  /// empty / url string / invalid -> icon
  static Widget _bannerImage(String image) {
    final clean = image.trim();

    if (clean.isEmpty || clean.toLowerCase() == 'url') {
      return const Center(child: Icon(Icons.image));
    }

    final fixedUrl = clean.startsWith('http://')
        ? clean.replaceFirst('http://', 'https://')
        : clean;

    return Image.network(
      fixedUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.broken_image));
      },
    );
  }

  /// ADD BANNER DIALOG
  void _showAddDialog(BuildContext context, BannerAuth vm) {
    final titleController = TextEditingController();
    Uint8List? imageBytes;
    XFile? pickedFile;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add Banner"),
              content: SizedBox(
                width: 450,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    const SizedBox(height: 14),

                    /// Pick image from device
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

                    const SizedBox(height: 12),

                    /// Preview
                    _previewImage(bytes: imageBytes),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await vm.addBanner(
                      title: titleController.text.trim(),
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

  /// EDIT BANNER DIALOG
  void _showEditDialog(
      BuildContext context,
      BannerAuth vm,
      BannerModel item,
      ) {
    final titleController = TextEditingController(text: item.title);
    Uint8List? imageBytes;
    XFile? pickedFile;

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit Banner"),
              content: SizedBox(
                width: 450,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    const SizedBox(height: 14),

                    /// Change image from device
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

                    const SizedBox(height: 12),

                    /// Preview selected or existing image
                    _previewImage(
                      bytes: imageBytes,
                      existingImage: item.image,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await vm.updateBanner(
                      id: item.id,
                      title: titleController.text.trim(),
                      existingImage: item.image,
                      newImageBytes: imageBytes,
                      newImageName: pickedFile?.name,
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

  /// DELETE CONFIRM
  void _showDeleteDialog(
      BuildContext context,
      BannerAuth vm,
      BannerModel item,
      ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Banner"),
          content: Text('Do you want to delete "${item.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await vm.deleteBanner(item.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  /// Preview helper
  static Widget _previewImage({
    Uint8List? bytes,
    String existingImage = '',
  }) {
    if (bytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          bytes,
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    if (existingImage.isNotEmpty && existingImage.toLowerCase() != 'url') {
      final fixedUrl = existingImage.startsWith('http://')
          ? existingImage.replaceFirst('http://', 'https://')
          : existingImage;

      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          fixedUrl,
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey.shade100,
              child: const Center(child: Icon(Icons.broken_image)),
            );
          },
        ),
      );
    }

    return Container(
      height: 120,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text("No image selected"),
    );
  }
}