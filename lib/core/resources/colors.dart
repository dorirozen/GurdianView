import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyColors {
  const MyColors._();
  static const Color primaryColor = Color(0xFF2196F3); // Example primary color
  static const Color accentColor = Color(0xFFFFC107); // Example accent color
  static const Color textColor = Color(0xFFDA1751); // Example text color
  static const Color backgroundColor =
      Color(0xFFFFFFFF); // Example background color
  static const Color errorColor = Color(0xFFE57373); // Example error color
  static const Color schemeColor = Colors.deepPurple;
  static const Color kcPrimaryColor = Color(0xff22A45D);
  static const Color kcRedColor = Color(0xfff44336);
  static const Color kcOrangeColor = Color(0xffff9800);
  static const Color kcMediumGreyColor = Color(0xff868686);
  static const Color kcLightGreyColor = Color(0xffe5e5e5);
  static const Color kcVeryLightGreyColor = Color(0xfff2f2f2);
  static const LinearGradient someLinear = LinearGradient(
    colors: [Color(0xFFFFC107), Color(0xFFFFA000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
