import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dash_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  static const routeName = '/dashboard';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

Widget _createDrawerItem(
    {required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isSelected}) {
  return ListTile(
    leading: Icon(icon, color: isSelected ? Colors.redAccent : Colors.grey),
    title: Text(title,
        style: TextStyle(color: isSelected ? Colors.redAccent : Colors.grey)),
    onTap: onTap,
  );
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardController>(
      builder: (_, controller, __) {
        return Scaffold(
          appBar: AppBar(
            // Use a Builder to create a context that is below the Scaffold
            leading: MediaQuery.of(context).size.width > 600
                ? Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      );
                    },
                  )
                : null,
            /*
            Scaffold.of(context).isDrawerOpen ? Scaffold.of(context).closeDrawer():null
             */
          ),
          // Drawer for larger screens
          drawer: MediaQuery.of(context).size.width > 600
              ? Drawer(
                  width: ScreenUtil().setWidth(100.0),
                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                        child: Text('Navigation'),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      _createDrawerItem(
                        icon: IconlyLight.home,
                        title: 'Home',
                        onTap: () {
                          controller.changeIndex(0);
                          Navigator.pop(context); // Close the drawer
                        },
                        isSelected: controller.currentIndex == 0,
                      ),
                      _createDrawerItem(
                        icon: IconlyLight.document,
                        title: 'Materials',
                        onTap: () {
                          controller.changeIndex(1);
                          Navigator.pop(context); // Close the drawer
                        },
                        isSelected: controller.currentIndex == 1,
                      ),
                      _createDrawerItem(
                        icon: IconlyLight.chat,
                        title: 'Chat',
                        onTap: () {
                          controller.changeIndex(2);
                          Navigator.pop(context); // Close the drawer
                        },
                        isSelected: controller.currentIndex == 2,
                      ),
                      _createDrawerItem(
                        icon: IconlyLight.profile,
                        title: 'Profile',
                        onTap: () {
                          controller.changeIndex(3);
                          Navigator.pop(context); // Close the drawer
                        },
                        isSelected: controller.currentIndex == 3,
                      ),
                    ],
                  ),
                )
              : null,

          body: IndexedStack(
            index: controller.currentIndex,
            children: controller.screens,
          ),

          // BottomNavigationBar for smaller screens
          bottomNavigationBar: MediaQuery.of(context).size.width <= 600
              ? BottomNavigationBar(
                  currentIndex: controller.currentIndex,
                  showSelectedLabels: false,
                  backgroundColor: Colors.white,
                  elevation: 8,
                  onTap: controller.changeIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 0
                            ? IconlyBold.home
                            : IconlyLight.home,
                        color: controller.currentIndex == 0
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      label: 'Home',
                      backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 1
                            ? IconlyBold.document
                            : IconlyLight.document,
                        color: controller.currentIndex == 1
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      label: 'Materials',
                      backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 2
                            ? IconlyBold.chat
                            : IconlyLight.chat,
                        color: controller.currentIndex == 2
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      label: 'Chat',
                      backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        controller.currentIndex == 3
                            ? IconlyBold.profile
                            : IconlyLight.profile,
                        color: controller.currentIndex == 3
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      label: 'Profile',
                      backgroundColor: Colors.white,
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
