import 'package:flutter/material.dart';

class DashboardQuickActionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? badge;

  final IconData icon;
  final Color color;

  final VoidCallback onTap;

  const DashboardQuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.subtitle,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: 3,
        shadowColor: Colors.black12,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          hoverColor: color.withOpacity(.05),
          splashColor: color.withOpacity(.10),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                /// Badge
                Align(
                  alignment: Alignment.topRight,
                  child: badge == null
                      ? const SizedBox(height: 22)
                      : Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(.12),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            badge!,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                ),

                const Spacer(),

                /// Icon
                CircleAvatar(
                  radius: 28,
                  backgroundColor: color.withOpacity(.12),
                  child: Icon(icon, color: color, size: 30),
                ),

                const SizedBox(height: 18),

                /// Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),

                if (subtitle != null) ...[
                  const SizedBox(height: 6),

                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
