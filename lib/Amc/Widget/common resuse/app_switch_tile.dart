import 'package:flutter/material.dart';

class AppSwitchTile extends StatelessWidget {
  final bool value;
  final String title;
  final String? subtitle;
  final ValueChanged<bool> onChanged;

  const AppSwitchTile({
    super.key,
    required this.value,
    required this.title,
    this.subtitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      value: value,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      onChanged: onChanged,
    );
  }
}
