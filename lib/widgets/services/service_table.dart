import 'package:admin_panel/core/App_permission/app_permission.dart';
import 'package:flutter/material.dart';
import '../../service_Api/services/services_auth.dart';
import '../../service_model/service_model/service_model.dart';

class ServiceTable extends StatelessWidget {
  final ServiceAuth vm;
  final void Function(ServiceModel item) onEdit;
  final void Function(ServiceModel item) onDelete;

  const ServiceTable({
    super.key,
    required this.vm,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: vm.paginatedServices.isEmpty
          ? const Center(child: Text("No services found"))
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  color: Colors.blue.shade50,
                  child: const Row(
                    children: [
                      Expanded(flex: 1, child: Text("#")),
                      Expanded(flex: 3, child: Text("Title")),
                      Expanded(flex: 2, child: Text("Category")),
                      Expanded(flex: 2, child: Text("Price")),
                      Expanded(flex: 2, child: Text("Cut Price")),
                      Expanded(flex: 2, child: Text("Discount %")),
                      Expanded(flex: 2, child: Text("Final Price")),
                      Expanded(flex: 2, child: Text("Image")),
                      Expanded(flex: 4, child: Text("Description")),
                      Expanded(flex: 4, child: Text("Highlights")),
                      Expanded(flex: 2, child: Text("Rating")),
                      Expanded(flex: 2, child: Text("Reviews")),
                      Expanded(flex: 2, child: Text("Time")),
                      Expanded(flex: 1, child: Text("Status")),
                      Expanded(flex: 1, child: Text("Edit")),
                      Expanded(flex: 1, child: Text("Delete")),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.paginatedServices.length,
                    itemBuilder: (context, index) {
                      final item = vm.paginatedServices[index];

                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Text("${item.id}")),
                            Expanded(
                              flex: 3,
                              child: Text(
                                item.title,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                item.categoryId == null
                                    ? "-"
                                    : "Category ${item.categoryId}",
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "₹${item.discountPrice.toStringAsFixed(0)}",
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("₹${item.price.toStringAsFixed(0)}"),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${item.discountPercent.toStringAsFixed(0)}%",
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "₹${item.discountPrice.toStringAsFixed(0)}",
                              ),
                            ),
                            Expanded(flex: 2, child: buildServiceImage(item)),
                            Expanded(
                              flex: 4,
                              child: Text(
                                item.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                item.highlights.isEmpty
                                    ? (item.isHighlighted ? "Highlighted" : "-")
                                    : item.highlights.join(" • "),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(item.rating?.toStringAsFixed(1) ?? "-"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("${item.reviewsCount} reviews"),
                            ),
                            Expanded(flex: 2, child: Text(item.time ?? "-")),
                            Expanded(
                              flex: 1,
                              child: Switch(
                                value: item.status,
                                onChanged: (_) async {
                                  await vm.toggleStatus(item.id, item.status);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => onEdit(item),
                              ),
                            ),

                            /// permission denied for admin
                            if (AppPermission.isSuperAdmin)
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => onDelete(item),
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
    );
  }

  Widget buildServiceImage(ServiceModel item) {
    final imageUrl = (item.imageUrl ?? '').trim();

    print("IMAGE URL => $imageUrl");

    if (imageUrl.isEmpty) {

      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image,color: Colors.yellow,),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        Uri.encodeFull(imageUrl),
        width: 50,
        height: 50,
        fit: BoxFit.cover,

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        },

        errorBuilder: (context, error, stackTrace) {
          print("IMAGE LOAD ERROR => $error");
          print("FAILED URL => $imageUrl");

          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.broken_image,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
