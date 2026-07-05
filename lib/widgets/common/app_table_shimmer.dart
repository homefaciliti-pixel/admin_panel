import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppTableShimmer extends StatelessWidget {
  final int rows;
  final int columns;
  final bool showHeader;

  const AppTableShimmer({
    super.key,
    this.rows = 8,
    this.columns = 10,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// HEADER
          if (showHeader)
            Container(
              height: 58,
              decoration: const BoxDecoration(
                color: Color(0xff111827),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
            ),

          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rows,
                itemBuilder: (_, index) {
                  return Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      children: List.generate(columns, (i) {
                        /// First column = Avatar
                        if (i == 1) {
                          return Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _line(90),
                                      const SizedBox(height: 8),
                                      _line(60),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _line(60),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(double width) {
    return Container(
      width: width,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
