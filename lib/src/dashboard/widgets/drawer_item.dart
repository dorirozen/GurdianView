import 'package:flutter/material.dart';

Widget createDrawerItem(
    {required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isSelected}) {
  return ListTile(
    leading: Icon(icon, color: isSelected ? Colors.redAccent : Colors.grey),
    title: Text(title,
        style: TextStyle(color: isSelected ? Colors.redAccent : Colors.grey)),
    onTap: onTap,
  );
}
