import 'package:flutter/material.dart';
import 'package:guardian_view/core/responsive/utils/ui_utils.dart';
import 'package:guardian_view/core/responsive_starter/entity/sizing_information.dart';

class RResponsiveBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, SSizingInformation sizingInformation) builder;

  const RResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(builder: (context, boxConstraints) {
      var sizingInformation = SSizingInformation(
          deviceType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize:
              Size(boxConstraints.maxWidth, boxConstraints.maxHeight));
      return builder(context, sizingInformation);
    });
  }
}
