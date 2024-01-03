import 'package:flutter/material.dart';
import 'package:guardian_view/core/resources/colors.dart';

class CoustomButton extends StatelessWidget {
  const CoustomButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed});
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.schemeColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
    );
  }
}
