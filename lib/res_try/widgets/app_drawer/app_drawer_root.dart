import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/responsive/orientation_layout.dart';
import 'package:guardian_view/res_try/responsive/screen_type_layout.dart';
import 'package:guardian_view/res_try/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:guardian_view/res_try/widgets/drawer_option/drawer_option_root.dart';

import 'app_drawer_tablet.dart';

class AppDrawerRoot extends StatelessWidget {
  const AppDrawerRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AppDrawerMobile(),
      tablet: OrientationLayout(
        portrait: AppDrawerTabletPortrait(),
        landscape: AppDrawerTabletLandscape(),
      ),
    );
  }

  static List<Widget> getDrawerOptions() {
    return [
      DrawerOptionRoot(
        title: 'Images',
        iconData: Icons.image,
      ),
      DrawerOptionRoot(
        title: 'Reports',
        iconData: Icons.photo_filter,
      ),
      DrawerOptionRoot(
        title: 'Incidents',
        iconData: Icons.message,
      ),
      DrawerOptionRoot(
        title: 'Settings',
        iconData: Icons.settings,
      ),
    ];
  }
}
