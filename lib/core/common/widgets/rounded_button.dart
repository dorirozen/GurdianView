
import 'package:flutter/material.dart';
import 'package:guardian_view/core/resources/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.buttonColor,
      this.labelColor})
      : super(key: key);
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? labelColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? MyColors.primaryColor,
          foregroundColor: labelColor ?? Colors.white,
          minimumSize: const Size(double.maxFinite, 50),
        ),
        onPressed: onPressed,
        child: Text(label));
  }
}

