import 'package:flutter/material.dart';
import 'package:guardian_view/core/enums/decive_screen_type.dart';

class SSizingInformation {
  final DeviceScreenType deviceType;
  final Size screenSize;
  final Size localWidgetSize;

  SSizingInformation({
    required this.deviceType,
    required this.screenSize,
    required this.localWidgetSize,
  });

  @override
  String toString() {
    return 'DeviceType:$deviceType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}
