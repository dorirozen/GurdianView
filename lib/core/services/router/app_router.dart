import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/core/common/dialog/dialog_manager.dart';
import 'package:guardian_view/core/common/views/page_un_implemented.dart';
import 'package:guardian_view/core/extentions/context_extensions.dart';
import 'package:guardian_view/core/responsive/views/home/home_root_view.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';
import 'package:guardian_view/src/auth/data/models/user_model.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_bloc.dart';
import 'package:guardian_view/src/auth/presention/views/sign_in_screen.dart';
import 'package:guardian_view/src/auth/presention/views/sign_up_screen.dart';
import 'package:guardian_view/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:guardian_view/src/on_boarding/presention/cubit/on_boarding_cubit.dart';
import 'package:guardian_view/src/on_boarding/presention/screens/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../src/dashboard/views/dash_board.dart';
import '../../../src/connection/logic/cubit/internet_cubit.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/d':
      return _pageBuilder((_) => HomeRootView(), settings: settings);
    //case '/t':
    //return _pageBuilder((_) => AlertsFromUrl(), settings: settings);
    case '/':
      final pref = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (pref.getBool(kFirstTimerKey) ?? true) {
            debugPrint('');
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            // pushing the user into the dashboard and we need his info
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
                uid: user.uid,
                email: user.email ?? '',
                city: '',
                phoneNum: '',
                fullName: user.displayName ?? '');
            context.userProvider.initUser(localUser);
            debugPrint('from router');
            /*
            final u = context.read<UserProvider>().user;
            debugPrint('LocalUser{uid: ${u?.uid}, email: ${u?.email}, bio: '
                '${u?.bio}, points: ${u?.points}, fullName: ${u?.fullName}, profilePic: ${u?.profilePic}');
             */
            return BlocProvider(
                create: (_) => sl<InternetCubit>(),
                child: const DashBoardScreen());
          }
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
          (_) => BlocProvider(
                create: (_) => sl<AuthBloc>(),
                child: const SignInScreen(),
              ),
          settings: settings);
    case SignUpScreen.routeName:
      return _pageBuilder(
          (_) => BlocProvider(
                create: (_) => sl<AuthBloc>(),
                child: const SignUpScreen(),
              ),
          settings: settings);
    case DashBoardScreen.routeName:
      return _pageBuilder(
          (_) => BlocProvider(
              create: (_) => sl<InternetCubit>(),
              child: const DashBoardScreen()),
          settings: settings);

    case PageUnImplemented.routeName:
      return _pageBuilder(
        (_) => const PageUnImplemented(),
        settings: settings,
      );
    //normal approach
    /*
    case "OnBoardingScreen.routeName":
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
      );
     */

    /*
    case '/':
      return _pageBuilder(
          (_) => HomeScreen(
                title: "Home Screen",
                color: Colors.blueAccent,
              ),
          settings: settings);
     */
    default:
      return _pageBuilder(
        (_) => const PageUnImplemented(txt: 'Default Page'),
        settings: settings,
      );
  }
}

///
PageRouteBuilder<dynamic> _pageBuilder(
    Widget Function(BuildContext context) page,
    {required RouteSettings settings}) {
  return PageRouteBuilder(
      settings: settings,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
      pageBuilder: (context, _, __) => DialogManager(child: page(context)));
}
