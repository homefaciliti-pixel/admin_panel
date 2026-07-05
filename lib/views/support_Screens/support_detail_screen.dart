import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service_Api/support_auth.dart';

class SupportDetailsScreen extends StatefulWidget {
  final int ticketId;

  const SupportDetailsScreen({super.key, required this.ticketId});

  @override
  State<SupportDetailsScreen> createState() => _SupportDetailsScreenState();
}

class _SupportDetailsScreenState extends State<SupportDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<SupportAuth>().getSupportDetails(widget.ticketId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SupportAuth>(
      builder: (context, vm, child) {
        if (vm.isLoading || vm.ticketDetail == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final ticket = vm.ticketDetail!;

        return Scaffold(
          appBar: AppBar(title: Text("Ticket #${ticket.id}")),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// Status
                Align(
                  alignment: Alignment.centerRight,
                  child: Chip(
                    backgroundColor: ticket.status == "Open"
                        ? Colors.green.shade100
                        : Colors.red.shade100,

                    label: Text(ticket.status),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "User Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const Divider(),

                Text("Name : ${ticket.userName}"),

                Text("Email : ${ticket.email}"),

                Text("Mobile : ${ticket.mobile}"),

                const SizedBox(height: 25),

                const Text(
                  "Issue Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const Divider(),

                Text("Subject : ${ticket.subject}"),

                const SizedBox(height: 10),

                Text(ticket.message),

                const SizedBox(height: 10),

                Text("Created : ${ticket.createdAt}"),

                const SizedBox(height: 30),

                if (ticket.partner != null) ...[
                  const Text(
                    "Partner Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const Divider(),

                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(ticket.partner!.image),
                  ),

                  const SizedBox(height: 15),

                  Text("Name : ${ticket.partner!.name}"),

                  Text("Email : ${ticket.partner!.email}"),

                  Text("Mobile : ${ticket.partner!.mobile}"),
                ],

                const SizedBox(height: 35),

                if (ticket.status == "Open")
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await vm.closeTicket(ticket.id);

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Ticket Closed Successfully"),
                            ),
                          );
                        }
                      },

                      child: const Text("Close Ticket"),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
