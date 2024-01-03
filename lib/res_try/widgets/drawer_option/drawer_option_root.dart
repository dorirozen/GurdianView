import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/responsive/orientation_layout.dart';
import 'package:guardian_view/res_try/responsive/screen_type_layout.dart';
import 'drawer_option_mobile.dart';
import 'drawer_option_tablet.dart';

class DrawerOptionRoot extends StatelessWidget {
  final String title;
  final IconData iconData;
  const DrawerOptionRoot({
    super.key,
    required this.title,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        landscape: DrawerOptionMobileLandscape(iconData: iconData),
        portrait: DrawerOptionMobilePortrait(title: title, iconData: iconData),
      ),
      tablet: OrientationLayout(
        portrait: DrawerOptionTabletPortrait(iconData: iconData, title: title),
        landscape: DrawerOptionMobilePortrait(iconData: iconData, title: title),
      ),
    );
  }
}
