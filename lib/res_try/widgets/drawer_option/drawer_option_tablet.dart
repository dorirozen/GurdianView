import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/base_model_widget.dart';
import 'package:guardian_view/res_try/drawer_item_data.dart';

class DrawerOptionTabletPortrait extends BaseModelWidget<DrawerItemData> {
  const DrawerOptionTabletPortrait({super.key});

  @override
  Widget build(BuildContext context, DrawerItemData data) {
    return Container(
      width: 152,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            data.iconData ?? Icons.add,
            size: 45,
          ),
          Text(data.title ?? '', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
