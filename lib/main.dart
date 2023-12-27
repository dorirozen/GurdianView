/*
import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'code_helpers/bloc_observer.dart';
import 'dashboard/dash_board.dart';
import 'dashboard/dash_controller.dart';
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
        create: (_) => DashBoardController(),
        child: MaterialApp(
          builder: DevicePreview.appBuilder,
          title: 'Guardian View App',
          theme: ThemeData.light(),
          //darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: const DashBoardScreen(),
        ),
      ),
    );
  }
}
*/
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connection/logic/cubit/internet_cubit.dart';
import 'connection/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(
        appRouter: AppRouter(),
        connectivity: Connectivity(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    super.key,
    required this.appRouter,
    required this.connectivity,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
