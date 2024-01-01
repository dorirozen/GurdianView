import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';
import 'package:guardian_view/core/utils/core_utils.dart';
import 'package:guardian_view/src/auth/data/models/user_model.dart';
import 'package:guardian_view/src/dashboard/utils/dash_board_utils.dart';
import 'package:guardian_view/src/dashboard/widgets/drawer_item.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../connection/constants/enums.dart';
import '../../connection/logic/cubit/internet_cubit.dart';
import '../providers/dash_controller.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  static const routeName = '/dashboard';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
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
    return StreamBuilder<LocalUserModel>(
      stream: DashBoardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is LocalUserModel) {
          //context.read<UserProvider>().user = snapshot.data;
          context.userProvider.user = snapshot.data;
        }
        return Consumer<DashBoardController>(
          builder: (_, controller, __) {
            return Scaffold(
              extendBodyBehindAppBar: false,
              appBar: MediaQuery.of(context).size.width > 600
                  ? AppBar(
                      // Use a Builder to create a context that is below the Scaffold
                      leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        );
                      },
                    ))
                  : null,
              // Drawer for larger screens
              drawer: MediaQuery.of(context).size.width > 600
                  ? Drawer(
                      width: 100.0.w,
                      child: ListView(
                        children: <Widget>[
                          DrawerHeader(
                            child: Text('Navigation'),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                          ),
                          createDrawerItem(
                            icon: IconlyLight.home,
                            title: 'Home',
                            onTap: () {
                              controller.changeIndex(0);
                              Navigator.pop(context); // Close the drawer
                            },
                            isSelected: controller.currentIndex == 0,
                          ),
                          createDrawerItem(
                            icon: IconlyLight.document,
                            title: 'Materials',
                            onTap: () {
                              controller.changeIndex(1);
                              Navigator.pop(context); // Close the drawer
                            },
                            isSelected: controller.currentIndex == 1,
                          ),
                          createDrawerItem(
                            icon: IconlyLight.chat,
                            title: 'Chat',
                            onTap: () {
                              controller.changeIndex(2);
                              Navigator.pop(context); // Close the drawer
                            },
                            isSelected: controller.currentIndex == 2,
                          ),
                          createDrawerItem(
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

              body: BlocListener<InternetCubit, InternetState>(
                listener: (context, state) {
                  if (state is InternetLoading) {
                    CoreUtils.showSnackBar(
                        context, 'checking internet connection');
                  } else if (state is InternetStatus &&
                      state.connectionType == ConnectionType.wifi) {
                    CoreUtils.showSnackBar(
                        context, 'You are on line !', Colors.green);
                  } else if (state is InternetStatus &&
                      state.connectionType == ConnectionType.none) {
                    CoreUtils.showSnackBar(
                        context, 'You are off line !', Colors.red);
                  }
                },
                child: IndexedStack(
                  index: controller.currentIndex,
                  children: controller.screens,
                ),
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
      },
    );
  }
}
