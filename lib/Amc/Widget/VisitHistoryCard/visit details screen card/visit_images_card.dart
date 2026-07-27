import 'package:flutter/material.dart';
 import '../../../Amc_Model/amc_dashboard/today_visit_model.dart';



class VisitImagesCard extends StatelessWidget {
  final VisitModel visit;
  const VisitImagesCard({
    super.key,
    required this.visit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.photo_library,
                  color: Colors.blue,
                ),

                SizedBox(width: 10),

                Text(
                  "Visit Images",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const Divider(height: 25),

            Row(
              children: [

                Expanded(
                  child: _imageBox(
                    context,
                    title: "Before",
                    image: visit.beforeImage,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _imageBox(
                    context,
                    title: "After",
                    image: visit.afterImage,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
  Widget _imageBox(
      BuildContext context, {
        required String title,
        String? image,
      }) {
    final imageUrl = image ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(title),

        const SizedBox(height: 10),

        GestureDetector(
          onTap: imageUrl.isEmpty
              ? null
              : () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: InteractiveViewer(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
          child: Container(
            height: 180,
            child: imageUrl.isEmpty
                ? const Center(
              child: Text("No Image"),
            )
                : Image.network(imageUrl),
          ),
        ),
      ],
    );
  }


}