import 'package:flutter/material.dart';

class PopUpItem extends StatelessWidget {
  const PopUpItem({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        icon,
      ],
    );
  }
}
