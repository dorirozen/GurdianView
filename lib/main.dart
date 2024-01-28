import 'package:device_preview/device_preview.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guardian_view/core/common/app/providers/user_provider.dart';
import 'package:guardian_view/core/common/dialog/dialog_manager.dart';
import 'package:guardian_view/core/common/dialog/example_of_using_dialog.dart';
import 'package:guardian_view/core/helpers/bloc_observer.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';
import 'package:guardian_view/core/services/router/app_router.dart';
import 'package:guardian_view/core/services/router/router_observer.dart';
import 'package:guardian_view/res_try/views/home/home_view_root.dart';
import 'package:guardian_view/res_try/widgets/app_drawer/app_drawer_root.dart';
import 'package:guardian_view/src/alerts/presention/views/alerts_view.dart';
import 'package:guardian_view/src/dashboard/providers/dash_controller.dart';
import 'package:guardian_view/src/profile_try/ui.dart';
import 'package:guardian_view/src/theme/app_theme.dart';
import 'package:guardian_view/src/theme/theme_provider.dart';
import 'package:guardian_view/temp.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

/// trying little part of code
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initInjection();
  Bloc.observer = AppBlocObserver();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
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
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          title: 'Guardian View App',
          debugShowCheckedModeBanner: false,
          home: MyListView(),
        ),
      ),
    );
  }
}

// i took the code of "all app main" and i make it simpler.
//לוקח את הקוד ויוצר את הגרסא הכי הכי פשוטה שלו כדי העיקר לרוץ על הפרוייקט
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initInjection();
  Bloc.observer = AppBlocObserver();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
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
          initialRoute: '/',
          onGenerateRoute: onGenerateRoute,
          //home: const DashBoardScreen(),
        ),
      ),
    );
  }
}
*/
/// all app main
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
          initialRoute: '/',
          onGenerateRoute: onGenerateRoute,
          //home: const DashBoardScreen(),
        ),
      ),
    );
  }
}
*/
/// responsive main done !!
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///app check
  /*
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
  );
 */
  await initInjection();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
  /*
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(),
  ));
   */
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
/*
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    debugPrint('app disposed');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.hidden:
      //All views of an application are hidden, either
      //because the application is about to be paused
      //(on iOS and Android), or because it has been
      //minimized or placed on a desktop that is no longer visible
      case AppLifecycleState.inactive:
      // The app is inactive (not receiving user input)
      case AppLifecycleState.paused:
        debugPrint('paused inactive hidden');
        // The app is paused (moved to the background)
        // Cancel Firestore listeners here
        if (sl.isRegistered<AlertCubit>()) {
          final alertCubit = sl<AlertCubit>();
          if (alertCubit.checkStreamInitialized()) {
            alertCubit.pauseSubscription();
          }
        }
        break;
      case AppLifecycleState.resumed:
        debugPrint('resumed');
        // The app is resumed (brought back to the foreground)
        // Resume Firestore listeners or other operations here
        if (sl.isRegistered<AlertCubit>()) {
          final alertCubit = sl<AlertCubit>();
          if (alertCubit.checkStreamInitialized()) {
            alertCubit.resumeSubscription(); // Resume the paused subscription
          }
        }
        break;
      case AppLifecycleState.detached:
        debugPrint('detached');
        if (sl.isRegistered<AlertCubit>()) {
          final alertCubit = sl<AlertCubit>();
          if (alertCubit.checkStreamInitialized()) {
            alertCubit.close(); // Resume the paused subscription
          }
        }
        break;
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DialogManager(
            child:
                ExampleOfUsingDialog())); /*BlocProvider(
            create: (_) => sl<VideoCubit>(),
            child:
                const UploadVideo())); */ // AlertsWidget())); //HomeViewRoot());
  }
}
*/
///video + alert ui done
/*
void main() => runApp(DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ));

/*
void main() => runApp(
      MyApp(),
    );
 */
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  /*
  @override

  void initState() {
    debugPrint('app init');
    super.initState();
    debugPrint('app init2');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    debugPrint('app disposed');
    WidgetsBinding.instance.removeObserver(this);
    debugPrint('app disposed1');
    super.dispose();
    debugPrint('app disposed2');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('here');
    super.didChangeAppLifecycleState(state);
    debugPrint('here1');
    switch (state) {
      case AppLifecycleState.hidden:
      //All views of an application are hidden, either
      //because the application is about to be paused
      //(on iOS and Android), or because it has been
      //minimized or placed on a desktop that is no longer visible
      case AppLifecycleState.inactive:
      // The app is inactive (not receiving user input)
      case AppLifecycleState.paused:
        debugPrint('paused inactive hidden');
        // The app is paused (moved to the background)
        // Cancel Firestore listeners here
        if (sl.isRegistered<AlertCubit>()) {
          final alertCubit = sl<AlertCubit>();
          if (alertCubit.checkStreamInitialized()) {
            alertCubit.pauseSubscription();
          }
        }
        break;
      case AppLifecycleState.resumed:
        debugPrint('resumed');
        // The app is resumed (brought back to the foreground)
        // Resume Firestore listeners or other operations here
        if (sl.isRegistered<AlertCubit>()) {
          final alertCubit = sl<AlertCubit>();
          if (alertCubit.checkStreamInitialized()) {
            alertCubit.resumeSubscription(); // Resume the paused subscription
          }
        }
        break;
      case AppLifecycleState.detached:
        debugPrint('detached');
        if (sl.isRegistered<AlertCubit>()) {
          final alertCubit = sl<AlertCubit>();
          if (alertCubit.checkStreamInitialized()) {
            alertCubit.close();
          }
        }
        break;
    }
  }
*/
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AlertListPage()); //VideoDemo());
  }
}
*/
