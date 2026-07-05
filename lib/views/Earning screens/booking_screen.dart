import 'package:admin_panel/service_Api/Earnings/Bookings/booking_auth.dart';
import 'package:admin_panel/widgets/common/app_table_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booking_details_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();

    /// Screen open hote hi API call
    Future.microtask(() {
      context.read<BookingAuth>().loadBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingAuth>(
      builder: (context, vm, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// =====================================
              /// PAGE HEADER
              /// =====================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// LEFT TITLE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Bookings",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Home > Bookings",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  /// SEARCH FIELD
                  Row(
                    children: [

                      SizedBox(
                        width: 260,
                        child: TextField(
                          onChanged: vm.searchBookings,
                          decoration: InputDecoration(
                            hintText: "Search Booking",
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


                      const SizedBox(width: 12),


                      ElevatedButton.icon(
                        onPressed: () {

                          vm.filterTodayBookings();

                        },
                        icon: const Icon(
                          Icons.today,
                          size: 18,
                        ),
                        label: Text(
                          vm.showTodayOnly
                              ? "All Booking"
                              : "Today",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: vm.showTodayOnly
                              ? Colors.green
                              : const Color(0xff111827),

                          foregroundColor: Colors.white,

                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// =====================================
              /// LOADING / ERROR / EMPTY STATE
              /// =====================================
              if (vm.isLoading)
                const Expanded(child: AppTableShimmer(rows: 8, columns: 7))
              else if (vm.error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      vm.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (vm.bookingEarnings.isEmpty)
                const Expanded(child: Center(child: Text("No Booking Found")))
              else ...[
                /// =====================================
                /// SUMMARY CARDS
                /// =====================================
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _summaryCard(
                      title: "Total Booking Earnings",
                      value: "₹${vm.totalBookingEarning.toStringAsFixed(0)}",
                      icon: Icons.currency_rupee,
                    ),
                    _summaryCard(
                      title: "Total Transactions",
                      value: "${vm.totalBookingCount}",
                      icon: Icons.receipt_long,
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                /// =====================================
                /// BOOKINGS TABLE
                /// =====================================
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              const Color(0xff111827),
                            ),
                            headingTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            columns: const [
                              DataColumn(label: Text("CUSTOMER")),
                              DataColumn(label: Text("TRANSACTION ID")),
                              DataColumn(label: Text("SERVICE AMOUNT")),
                              DataColumn(label: Text("PAYMENT METHOD")),
                              DataColumn(label: Text("EXTRA SERVICE AMOUNT")),
                              DataColumn(
                                label: Text("EXTRA SERVICE PAYMENT METHOD"),
                              ),
                              DataColumn(label: Text("TOTAL AMOUNT")),
                              DataColumn(label: Text("ORDER DATE")),
                            ],
                            rows: vm.bookingEarnings.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      item.userDetails?.name ?? "Deleted User",
                                    ),
                                  ),
                                  DataCell(
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                BookingDetailsScreen(
                                                  booking: item,
                                                ),
                                          ),
                                        );
                                      },

                                      child: Text(
                                        item.transactionId,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "₹${item.serviceAmount.toStringAsFixed(0)}",
                                    ),
                                  ),
                                  DataCell(Text(item.paymentMethod)),
                                  DataCell(
                                    Text(
                                      "₹${item.extraServiceAmount.toStringAsFixed(0)}",
                                    ),
                                  ),
                                  DataCell(
                                    Text(item.extraServicePaymentMethod),
                                  ),
                                  DataCell(
                                    Text(
                                      "₹${item.totalAmount.toStringAsFixed(0)}",
                                    ),
                                  ),
                                  DataCell(Text(item.orderDate)),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  /// =========================================
  /// SUMMARY CARD
  /// =========================================
  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xff111827),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
