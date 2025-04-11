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
import 'package:guardian_view/src/video/presention/cubit/video_cubit.dart';
import 'package:guardian_view/src/video/presention/views/video_adding.dart';
import 'package:guardian_view/temp.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await initInjection();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            BlocProvider(
                create: (_) => sl<VideoCubit>(),
                child:
                    const UploadVideo())); 
  }
}

