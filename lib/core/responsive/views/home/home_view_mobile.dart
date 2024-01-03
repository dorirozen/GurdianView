import 'package:flutter/material.dart';
import 'package:guardian_view/core/responsive/views/home/widgets/app_drawer/app_drawer.dart';

/// Contains the widgets that will used for  Mobile layout of home , portrait and landscape

class HomeMobilePortrait extends StatelessWidget {
  HomeMobilePortrait({super.key});

  /// TODO: to check when to use it like that . and when like [Scaffold.of(context).openDrawer();]
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
                onPressed: () {
                  //_scaffoldKey.currentState?.openDrawer();
                  Scaffold.of(context).openDrawer();
                },
              ),
            )
          ],
        );
      }),
    );
  }
}

class HomeViewMobileLandscape extends StatelessWidget {
  const HomeViewMobileLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[AppDrawer()],
      ),
    );
  }
}
