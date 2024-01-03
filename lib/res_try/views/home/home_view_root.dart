import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/responsive/orientation_layout.dart';
import 'package:guardian_view/res_try/responsive/screen_type_layout.dart';
import 'home_view_mobile.dart';
import 'home_view_tablet.dart';

class HomeViewRoot extends StatelessWidget {
  const HomeViewRoot({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('1');
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: HomeMobilePortrait(),
        landscape: HomeMobileLandscape(),
      ),
      tablet: HomeViewTablet(),
    );
  }
}
