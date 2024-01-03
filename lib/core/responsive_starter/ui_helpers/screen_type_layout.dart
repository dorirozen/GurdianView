import 'package:flutter/material.dart';
import 'package:guardian_view/core/enums/decive_screen_type.dart';
import 'package:guardian_view/core/responsive_starter/ui_helpers/base_widget.dart';

class SScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const SScreenTypeLayout(
      {super.key, required this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    return RResponsiveBuilder(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      if (sizingInformation.deviceType == DeviceScreenType.Tablet) {
        if (tablet != null) {
          return tablet!;
        }
      }

      // If sizing indicates desktop and we have a desktop widget then return
      if (sizingInformation.deviceType == DeviceScreenType.Desktop) {
        if (desktop != null) {
          return desktop!;
        }
      }

      // Return mobile layout if nothing else is supplied
      return mobile;
    });
  }
}
