import 'package:flutter/material.dart';

class AppEmptyView extends StatelessWidget {
  final String title;
  final IconData icon;

  const AppEmptyView({
    super.key,
    required this.title,
    this.icon = Icons.inbox,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            size: 70,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),

        ],
      ),
    );
  }
}