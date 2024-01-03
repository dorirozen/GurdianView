import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/widgets/app_drawer/app_drawer_root.dart';

class AppDrawerMobile extends StatelessWidget {
  const AppDrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      width: orientation == Orientation.portrait ? 250 : 100,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 16,
          color: Colors.black12,
        )
      ]),
      child: Column(
        children: AppDrawerRoot.getDrawerOptions(),
      ),
    );
  }
}
