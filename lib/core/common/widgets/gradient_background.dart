import 'package:flutter/material.dart';

class GradientBackGround extends StatelessWidget {
  const GradientBackGround(
      {Key? key, required this.image, required this.child, this.toUse})
      : super(key: key);
  final Widget child;
  final String image;
  final bool? toUse;

  @override
  Widget build(BuildContext context) {
    return toUse == null || toUse == true
        ? Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: child)
        : child;
  }
}
