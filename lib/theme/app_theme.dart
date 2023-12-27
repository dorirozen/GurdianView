import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightBackGroundColor = const Color(0xfff2f2f2);
  static Color lightPrimaryColor = const Color(0xfff2f2f2);
  static Color lightAccentColor = Colors.blueGrey.shade200;
  static Color lightParticleColor = const Color(0x44948282);

  static Color darkBackGroundColor = const Color(0xFF1A2127);
  static Color darkPrimaryColor = const Color(0xFF1A2127);
  static Color darkAccentColor = Colors.blueGrey.shade600;
  static Color darkParticleColor = const Color(0x441C2A3D);

  const AppTheme._();

  static final lightTheme = ThemeData(
      colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: lightPrimaryColor,
          secondary: lightAccentColor,
          background: lightBackGroundColor),
      visualDensity: VisualDensity.adaptivePlatformDensity);

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: darkPrimaryColor,
        secondary: darkAccentColor,
        background: darkBackGroundColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

extension ThemeExtras on ThemeData {
  Color get particlesColor => brightness == Brightness.light
      ? AppTheme.lightParticleColor
      : AppTheme.darkParticleColor;
}
