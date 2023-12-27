import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'code_helprts/bloc_observer.dart';
import 'final/dash_board_final.dart';
import 'final/dash_conroller_final.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
    const MyApp(), // Wrap your app
  );
   */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get onGenerateRoute => null;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(500.0, 730.4),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ChangeNotifierProvider(
        create: (_) => DashBoardControllerFinal(),
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          title: 'asd',
          theme: ThemeData.light(),
          //darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: const DashBoardScreenFinal(t: ''),
        ),
      ),
    );
  }
}
/*
return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const HomePage(title: 'First Method'),
    );
  }
 */
