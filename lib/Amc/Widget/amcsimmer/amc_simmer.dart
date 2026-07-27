import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardAmcShimmer extends StatelessWidget {
  const DashboardAmcShimmer({super.key});

  Widget box({
    double height = 150,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            box(height: 90),

            const SizedBox(height: 25),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                mainAxisExtent: 150,
              ),
              itemBuilder: (_, __) => box(),
            ),

            const SizedBox(height: 25),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                mainAxisExtent: 150,
              ),
              itemBuilder: (_, __) => box(),
            ),

            const SizedBox(height: 25),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                mainAxisExtent: 150,
              ),
              itemBuilder: (_, __) => box(),
            ),
          ],
        ),
      ),
    );
  }
}