import 'package:flutter/material.dart';

class AppLoadingView extends StatelessWidget {
  final String? message;

  const AppLoadingView({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),

          if (message != null) ...[
            const SizedBox(height: 16),

            Text(
              message!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],

        ],
      ),
    );
  }
}