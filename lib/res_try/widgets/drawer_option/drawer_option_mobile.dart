import 'package:flutter/material.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';
import 'package:guardian_view/res_try/base_model_widget.dart';
import 'package:guardian_view/res_try/drawer_item_data.dart';
import 'package:provider/provider.dart';

class DrawerOptionMobilePortrait extends BaseModelWidget<DrawerItemData> {
  const DrawerOptionMobilePortrait({super.key});

  @override
  Widget build(BuildContext context, DrawerItemData data) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      height: 80,
      child: Row(
        children: <Widget>[
          Icon(
            data.iconData ?? Icons.add,
            size: 25,
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            data.title ?? '',
            style: TextStyle(fontSize: 21),
          )
        ],
      ),
    );
  }
}

class DrawerOptionMobileLandscape extends BaseModelWidget<DrawerItemData> {
  const DrawerOptionMobileLandscape({super.key});

  @override
  Widget build(BuildContext context, DrawerItemData data) {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Icon(data.iconData),
    );
  }
}
