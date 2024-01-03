import 'package:flutter/material.dart';
import 'package:guardian_view/core/responsive_starter/ui_helpers/base_widget.dart';

class HHomeView extends StatelessWidget {
  const HHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return RResponsiveBuilder(

        /// created first !
        builder: (context, sizingInformation) {
      ///passes what to build
      return Scaffold(
          body: Center(
        child: Text(sizingInformation.toString()),
      ));
    });
  }
}
