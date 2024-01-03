import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guardian_view/core/common/app/providers/user_provider.dart';
import 'package:guardian_view/core/helpers/bloc_observer.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';
import 'package:guardian_view/core/services/router/app_router.dart';
import 'package:guardian_view/core/services/router/router_observer.dart';
import 'package:guardian_view/res_try/views/home/home_view_root.dart';
import 'package:guardian_view/res_try/widgets/app_drawer/app_drawer_root.dart';
import 'package:guardian_view/src/dashboard/providers/dash_controller.dart';
import 'package:guardian_view/src/theme/app_theme.dart';
import 'package:guardian_view/src/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
   */
  await initInjection();
  //TODO: check how to use this appropriately
  Bloc.observer = AppBlocObserver();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );

/*

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ], child: const MyApp()),
  );
 */
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(500.0, 730.4),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DashBoardController(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          navigatorObservers: [sl<MyNavigatorObserver>()],
          builder: DevicePreview.appBuilder,
          title: 'Guardian View App',
          //theme: AppTheme.lightTheme,
          //darkTheme: AppTheme.darkTheme,
          //themeMode:
          //    themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          initialRoute: '/d',
          onGenerateRoute: onGenerateRoute,
          //home: const DashBoardScreen(),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

/*

void main() => runApp(DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ));
 */
void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeViewRoot());
  }
}
