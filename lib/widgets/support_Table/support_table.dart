import 'package:flutter/material.dart';

import '../../service_Api/support_auth.dart';
import '../../service_model/support model/support_model.dart';

class SupportTable extends StatelessWidget {
  final List<SupportModel> tickets;
  final SupportAuth vm;
  final Function(SupportModel) onViewTap;
  final Function(SupportModel)? onDeleteTap;

  const SupportTable({
    super.key,
    required this.tickets,
    required this.vm,
    required this.onViewTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(const Color(0xffF3F4F6)),
          columns: const [
            DataColumn(label: Text("ID")),
            DataColumn(label: Text("User")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Mobile")),
            DataColumn(label: Text("Subject")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Date")),
            DataColumn(label: Text("Action")),
          ],
          rows: tickets.map((ticket) {
            return DataRow(
              cells: [
                DataCell(Text(ticket.id.toString())),

                DataCell(Text(ticket.userName)),

                DataCell(
                  SizedBox(
                    width: 180,
                    child: Text(ticket.email, overflow: TextOverflow.ellipsis),
                  ),
                ),

                DataCell(Text(ticket.mobile)),

                DataCell(
                  SizedBox(
                    width: 220,
                    child: Text(
                      ticket.subject,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: ticket.status == "Open"
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ticket.status,
                      style: TextStyle(
                        color: ticket.status == "Open"
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                DataCell(Text(ticket.createdAt)),

                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: "View",
                        icon: const Icon(Icons.visibility, color: Colors.blue),
                        onPressed: () => onViewTap(ticket),
                      ),

                      IconButton(
                        tooltip: "Delete",
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: onDeleteTap == null
                            ? null
                            : () => onDeleteTap!(ticket),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
