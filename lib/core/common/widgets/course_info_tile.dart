import 'package:flutter/material.dart';

class CourseInfoTile extends StatelessWidget {
  const CourseInfoTile(
      {Key? key,
      this.onTap,
      required this.image,
      required this.title,
      required this.subTitle})
      : super(key: key);
  final VoidCallback? onTap;
  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 48,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Transform.scale(
                scale: 1.48,
                child: Image.asset(image),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                subTitle,
                style: const TextStyle(fontSize: 12, color: Colors.redAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
