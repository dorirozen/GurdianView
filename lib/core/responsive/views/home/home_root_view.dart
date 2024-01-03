import 'package:flutter/material.dart';
import 'package:guardian_view/core/responsive/layout_helpers/orientation_layout.dart';
import 'package:guardian_view/core/responsive/layout_helpers/screen_type_layout.dart';
import 'package:guardian_view/core/responsive/views/home/home_view_mobile.dart';
import 'package:guardian_view/core/responsive/views/home/home_view_tablet.dart';

/// will have a lot of different layouts so here we gonna manage them .
// TODO: [i need to think how to use is as a controller next time ! ]
class HomeRootView extends StatelessWidget {
  const HomeRootView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: HomeMobilePortrait(),
        landscape: const HomeViewMobileLandscape(),
      ),
      tablet: HomeViewTablet(),

      /// thats another type of implementing
    );
  }
}
