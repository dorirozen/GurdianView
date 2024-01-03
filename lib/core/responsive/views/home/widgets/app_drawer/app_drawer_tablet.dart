import 'package:flutter/material.dart';
import 'package:guardian_view/core/responsive/views/home/widgets/app_drawer/app_drawer.dart';

class AppDrawerTabletPortrait extends StatelessWidget {
  const AppDrawerTabletPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: [
          BoxShadow(blurRadius: 16, color: Colors.redAccent),
        ],
      ),
      child: Row(
        children: AppDrawer.getDrawerOptions(),
      ),
    );
  }
}

class AppDrawerTabletLandScape extends StatelessWidget {
  const AppDrawerTabletLandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.green,
        boxShadow: [
          BoxShadow(blurRadius: 16, color: Colors.grey),
        ],
      ),
      child: Column(
        children: AppDrawer.getDrawerOptions(),
      ),
    );
  }
}
