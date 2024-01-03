import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:guardian_view/core/services/router/router_observer.dart';
import 'package:guardian_view/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:guardian_view/src/auth/data/repos/auth_repo_impl.dart';
import 'package:guardian_view/src/auth/domain/repos/auth_repo.dart';
import 'package:guardian_view/src/auth/domain/usecases/signInUS.dart';
import 'package:guardian_view/src/auth/domain/usecases/signUpUS.dart';
import 'package:guardian_view/src/auth/domain/usecases/updateUserUS.dart';
import 'package:guardian_view/src/auth/presention/bloc/auth_bloc.dart';
import 'package:guardian_view/src/connection/logic/cubit/internet_cubit.dart';
import 'package:guardian_view/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:guardian_view/src/on_boarding/data/repos_impl/on_boarding_repo_impl.dart';
import 'package:guardian_view/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:guardian_view/src/on_boarding/domain/usecases/cache_first_timer_US.dart';
import 'package:guardian_view/src/on_boarding/domain/usecases/check_if_user_first_time.dart';
import 'package:guardian_view/src/on_boarding/presention/cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  sl.registerSingleton(MyNavigatorObserver());
  await initApp();
  await _onBoardingInit();
  await _authInit();
}

Future<void> initApp() async {
  sl
    ..registerLazySingleton(() => Connectivity())
    ..registerLazySingleton(() => InternetCubit(connectivity: sl()));
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
        () => AuthBloc(signIn: sl(), signUp: sl(), updateUser: sl()))
    // when i user factory i need to provide with BlocProvider the instance !
    // if singleton so i dont .
    ..registerLazySingleton(() => SignInUS(sl()))
    ..registerLazySingleton(() => SignUpUS(sl()))
    ..registerLazySingleton(() => UpdateUserUS(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(() =>
        AuthRemoteDataSourceImpl(
            authClient: sl(), cloudStoreClient: sl(), dbClient: sl()))
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _onBoardingInit() async {
  final pref = await SharedPreferences.getInstance();
  sl
    ..registerFactory(() =>
        OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserFirstTime: sl()))
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
        () => OnBoardingLocalDataSrcImpl(sl()))
    ..registerLazySingleton(() => pref);
}
