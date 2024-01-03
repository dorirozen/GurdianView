import 'package:flutter/material.dart';
import 'package:guardian_view/core/responsive/layout_helpers/orientation_layout.dart';
import 'package:guardian_view/core/responsive/layout_helpers/screen_type_layout.dart';
import 'package:guardian_view/core/responsive/views/home/widgets/app_drawer/app_drawer_mobile.dart';
import 'package:guardian_view/core/responsive/views/home/widgets/app_drawer/app_drawer_tablet.dart';
import 'package:guardian_view/core/responsive/views/home/widgets/drawer_option/drawer_option.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      mobile: AppDrawerMobile(),
      tablet: OrientationLayout(
        portrait: AppDrawerTabletPortrait(),
        landscape: AppDrawerTabletLandScape(),
      ),
    );
  }

  static List<Widget> getDrawerOptions() {
    return [
      DrawerOption(title: 'Images', iconData: Icons.image),
      DrawerOption(title: 'Reports', iconData: Icons.photo_filter),
      DrawerOption(title: 'Incidents', iconData: Icons.message),
      DrawerOption(title: 'Settings', iconData: Icons.settings),
    ];
  }
}
