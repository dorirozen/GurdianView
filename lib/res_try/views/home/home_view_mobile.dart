/// Contains the widgets that will be used for Mobile layout of home,
/// portrait and landscape
import 'package:flutter/material.dart';
import 'package:guardian_view/res_try/base_model_widget.dart';
import 'package:guardian_view/res_try/views/viewmodels/home_view_model.dart';
import 'package:guardian_view/res_try/widgets/app_drawer/app_drawer_root.dart';

class HomeMobilePortrait extends BaseModelWidget<HomeViewModel> {
  HomeMobilePortrait({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model.updateTitle();
        },
      ),
      key: _scaffoldKey,
      drawer: AppDrawerRoot(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: IconButton(
              icon: Icon(Icons.menu, size: 30),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text(model.title),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeMobileLandscape extends BaseModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          AppDrawerRoot(),
          Expanded(
              child: Center(
            child: Text(
              model.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ))
        ],
      ),
    );
  }
}
