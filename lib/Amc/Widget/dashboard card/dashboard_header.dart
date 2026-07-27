import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String adminName;
  final VoidCallback? onNotification;
  final VoidCallback? onProfile;

  const DashboardHeader({
    super.key,
    this.adminName = "Admin",
    this.onNotification,
    this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [

          /// Welcome
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "AMC Dashboard",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Welcome Back, $adminName 👋",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                  ),
                ),

              ],
            ),
          ),

          /// Notification
          IconButton(
            onPressed: onNotification,
            icon: Badge(
              label: const Text("3"),
              child: const Icon(Icons.notifications_outlined),
            ),
          ),

          const SizedBox(width: 10),

          /// Profile
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onProfile,
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xffE3F2FD),
              child: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
          ),

        ],
      ),
    );
  }
}