import 'package:flutter/material.dart';
import 'package:guardian_view/core/responsive/layout_helpers/orientation_layout.dart';
import 'package:guardian_view/core/responsive/layout_helpers/screen_type_layout.dart';
import 'package:guardian_view/core/responsive/views/home/widgets/drawer_option/drawer_option_mobile.dart';
import 'package:guardian_view/core/responsive/views/home/widgets/drawer_option/drawer_option_tablet.dart';

class DrawerOption extends StatelessWidget {
  const DrawerOption({Key? key, required this.title, required this.iconData})
      : super(key: key);
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: DrawerOptionMobilePortrait(title: title, iconData: iconData),
        landscape: DrawerOptionMobileLandscape(iconData: iconData),
      ),
      tablet: OrientationLayout(
        portrait: DrawerOptionTabletPortrait(iconData: iconData, title: title),
        landscape: DrawerOptionMobilePortrait(iconData: iconData),
      ),
    );
  }
}
