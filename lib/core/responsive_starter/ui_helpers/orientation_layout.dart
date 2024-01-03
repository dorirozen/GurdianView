import 'package:flutter/material.dart';

class OOrientationLayout extends StatelessWidget {
  final Widget? landscape;
  final Widget portrait;

  const OOrientationLayout({super.key, this.landscape, required this.portrait});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape ?? portrait;
    }

    return portrait;
  }
}
