import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/drawer_item_data.dart';
import 'package:guardian_view/res_try/responsive/orientation_layout.dart';
import 'package:guardian_view/res_try/responsive/screen_type_layout.dart';
import 'package:provider/provider.dart';
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
    /// passing data down to responsive layouts
    /// and it easily integrated with all the layouts
    /// without too much code duplications
    return Provider<DrawerItemData>.value(
      value: DrawerItemData(iconData: iconData, title: title),
      child: ScreenTypeLayout(
        mobile: OrientationLayout(
          landscape: (context) => const DrawerOptionMobileLandscape(),
          portrait: (context) => const DrawerOptionMobilePortrait(),
        ),
        tablet: OrientationLayout(
          portrait: (context) => const DrawerOptionTabletPortrait(),
          landscape: (context) => const DrawerOptionMobilePortrait(),
        ),
      ),
    );
  }
}
