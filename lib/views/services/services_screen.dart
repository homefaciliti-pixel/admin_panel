import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../service_Api/services/services_auth.dart';
import '../../service_model/service_model/service_model.dart';
import '../../widgets/services/service_table.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceAuth>(
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
                        "Services",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Home > Services",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: vm.isLoading
                        ? null
                        : () {
                      _showServiceDialog(context, vm);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add New"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff111827),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// FILTER ROW
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
                        DropdownMenuItem(value: 10, child: Text("10 Entries")),
                        DropdownMenuItem(value: 20, child: Text("20 Entries")),
                        DropdownMenuItem(value: 50, child: Text("50 Entries")),
                        DropdownMenuItem(value: 100, child: Text("100 Entries")),
                      ],
                      onChanged: vm.isLoading
                          ? null
                          : (value) {
                        if (value != null) vm.changeEntries(value);
                      },
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _searchController,
                      onChanged: vm.searchService,
                      decoration: InputDecoration(
                        hintText: "Search Service",
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

              const SizedBox(height: 20),

              /// TABLE AREA
              Expanded(
                child: vm.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : vm.errorMessage != null
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vm.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          vm.fetchServices();
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
                    : Scrollbar(
                  controller: _horizontalController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    controller: _horizontalController,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1850,
                      child: ServiceTable(
                        vm: vm,
                        onEdit: (item) {
                          _showServiceDialog(context, vm, item: item);
                        },
                        onDelete: (item) async {
                          final ok = await _showDeleteDialog(
                            context,
                            vm,
                            item.id,
                            item.title,
                          );
                          if (ok == true && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Service deleted"),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

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
                          "Show",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
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
                            onChanged: vm.isLoading
                                ? null
                                : (value) {
                              if (value != null) vm.changeEntries(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text("entries"),
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
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(Icons.chevron_left),
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
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: vm.nextPage,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
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
    );
  }

  void _showServiceDialog(
      BuildContext context,
      ServiceAuth vm, {
        ServiceModel? item,
      }) {
    final titleController = TextEditingController(text: item?.title ?? "");
    final categoryController = TextEditingController(
      text: item?.categoryId?.toString() ?? "",
    );
    final priceController = TextEditingController(
      text: item == null ? "" : item.discountPrice.toStringAsFixed(0),
    );
    final cutPriceController = TextEditingController(
      text: item == null ? "" : item.price.toStringAsFixed(0),
    );
    final discountPercentController = TextEditingController(
      text: item == null ? "" : item.discountPercent.toStringAsFixed(0),
    );
    final descriptionController = TextEditingController(
      text: item?.description ?? "",
    );
    final ratingController = TextEditingController(
      text: item?.rating?.toString() ?? "",
    );
    final reviewsController = TextEditingController(
      text: item?.reviewsCount.toString() ?? "",
    );
    final timeController = TextEditingController(text: item?.time ?? "");
    final highlightController = TextEditingController();

    List<int>? pickedImageBytes = item?.imageBytes;
    final String? existingImageUrl = item?.imageUrl;
    List<String> highlights = List<String>.from(item?.highlights ?? []);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> pickImage() async {
              final picker = ImagePicker();
              final XFile? picked =
              await picker.pickImage(source: ImageSource.gallery);

              if (picked != null) {
                final bytes = await picked.readAsBytes();
                setState(() {
                  pickedImageBytes = bytes.toList();
                });
              }
            }

            Widget buildImagePreview() {
              if (pickedImageBytes != null && pickedImageBytes!.isNotEmpty) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.memory(
                    Uint8List.fromList(pickedImageBytes!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 140,
                  ),
                );
              }

              if (existingImageUrl != null && existingImageUrl.isNotEmpty) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    existingImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 140,
                    errorBuilder: (_, __, ___) {
                      return const Center(
                        child: Icon(Icons.image, size: 32),
                      );
                    },
                  ),
                );
              }

              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, size: 32),
                  SizedBox(height: 8),
                  Text("Tap to select image from gallery"),
                ],
              );
            }

            return AlertDialog(
              title: Text(item == null ? "Add Service" : "Edit Service"),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 520,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: buildImagePreview(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _dialogField(titleController, "Title"),
                      const SizedBox(height: 14),
                      _dialogField(categoryController, "Category ID"),
                      const SizedBox(height: 14),
                      _dialogField(
                        priceController,
                        "Price",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 14),
                      _dialogField(
                        cutPriceController,
                        "Cut Price",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 14),
                      _dialogField(
                        discountPercentController,
                        "Discount %",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 14),
                      _dialogField(
                        descriptionController,
                        "Description",
                        maxLines: 3,
                      ),
                      const SizedBox(height: 14),
                      _dialogField(
                        ratingController,
                        "Rating",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 14),
                      _dialogField(
                        reviewsController,
                        "Reviews Count",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 14),
                      _dialogField(timeController, "Service Time"),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Service Highlights",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: highlightController,
                              decoration: const InputDecoration(
                                hintText: "Add highlight text",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              final text = highlightController.text.trim();
                              if (text.isNotEmpty) {
                                setState(() {
                                  highlights.add(text);
                                  highlightController.clear();
                                });
                              }
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (highlights.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: highlights.asMap().entries.map((entry) {
                            return Chip(
                              label: Text(entry.value),
                              deleteIcon: const Icon(Icons.close, size: 18),
                              onDeleted: () {
                                setState(() {
                                  highlights.removeAt(entry.key);
                                });
                              },
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: vm.isLoading
                      ? null
                      : () async {
                    final title = titleController.text.trim();
                    final categoryId = categoryController.text.trim().isEmpty ? null : categoryController.text.trim();
                    final price =
                        double.tryParse(priceController.text.trim()) ?? 0;
                    final cutPrice =
                        double.tryParse(cutPriceController.text.trim()) ?? 0;
                    final discountPercent =
                        double.tryParse(discountPercentController.text.trim()) ?? 0;
                    final description = descriptionController.text.trim();
                    final rating =
                        double.tryParse(ratingController.text.trim()) ?? 0;
                    final reviewsCount =
                        int.tryParse(reviewsController.text.trim()) ?? 0;
                    final serviceTime = timeController.text.trim();

                    if (title.isEmpty || description.isEmpty) {
                      return;
                    }

                    final ok = item == null
                        ? await vm.addService(
                      title: title,
                      categoryId: categoryId,
                      price: price,
                      cutPrice: cutPrice,
                      discountPercent: discountPercent,
                      imageBytes: pickedImageBytes,
                      description: description,
                      highlights: highlights,
                      rating: rating,
                      reviewsCount: reviewsCount,
                      serviceTime: serviceTime,
                    )
                        : await vm.updateService(
                      id: item.id,
                      title: title,
                      categoryId: categoryId,
                      price: price,
                      cutPrice: cutPrice,
                      discountPercent: discountPercent,
                      imageBytes: pickedImageBytes,
                      description: description,
                      highlights: highlights,
                      rating: rating,
                      reviewsCount: reviewsCount,
                      serviceTime: serviceTime,
                      existingImageUrl: item?.imageUrl,
                    );

                    if (ok && context.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: Text(item == null ? "Save" : "Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }




  Widget _dialogField(
      TextEditingController controller,
      String label, {
        TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(
      BuildContext context,
      ServiceAuth vm,
      int id,
      String title,
      ) {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Service"),
          content: Text('Do you want to delete "$title"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final ok = await vm.deleteService(id);
                if (context.mounted) {
                  Navigator.pop(context, ok);
                }
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
}