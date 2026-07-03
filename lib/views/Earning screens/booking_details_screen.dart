import 'package:flutter/material.dart';
import '../../service_model/earnings_model/Booking_model/booking_model.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingModel booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final user = booking.userDetails;

    return Container(
      padding: const EdgeInsets.all(25),
      color: const Color(0xffF5F7FB),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Booking Details",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 25),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _card(
                  title: "Customer Information",
                  children: [
                    _row("Name", user?.name ?? "Deleted User"),

                    _row("Mobile", user?.mobile ?? "-"),

                    _row("Email", user?.email ?? "-"),

                    _row("Address", user?.address ?? "-"),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _card(
                  title: "Booking Information",
                  children: [
                    _row("Booking ID", "#${booking.id}"),

                    _row("Transaction", booking.transactionId),

                    _row("Date", booking.orderDate),

                    _row("Payment", booking.paymentMethod),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _card(
            title: "Payment Summary",
            children: [
              _row("Service Amount", "₹${booking.serviceAmount}"),

              _row("Extra Service", "₹${booking.extraServiceAmount}"),

              _row("Total Amount", "₹${booking.totalAmount}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _card({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize:16,
              fontWeight:FontWeight.bold,
            ),
          ),

          const Divider(),

          ...children,
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 160,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              softWrap: true,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
