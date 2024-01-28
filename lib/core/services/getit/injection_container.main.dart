import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:guardian_view/core/common/dialog/dialog_bridge_service.dart';
import 'package:guardian_view/core/services/router/router_observer.dart';
import 'package:guardian_view/src/alerts/data/data_sources/remote_data_source.dart';
import 'package:guardian_view/src/alerts/data/repo_impl_alerts/repo_impl_alert.dart';
import 'package:guardian_view/src/alerts/domain/repo_alert/repo_alert.dart';
import 'package:guardian_view/src/alerts/domain/usercases/get_alerts_ui.dart';
import 'package:guardian_view/src/alerts/presention/cubit/alert_cubit.dart';
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
import 'package:guardian_view/src/video/data/data_sources/remote_data_source.dart';
import 'package:guardian_view/src/video/data/repos_impl/repo_video_impl.dart';
import 'package:guardian_view/src/video/domain/repo_video/repo_video.dart';
import 'package:guardian_view/src/video/domain/usecases/add_video_us.dart';
import 'package:guardian_view/src/video/domain/usecases/post_upload_us.dart';
import 'package:guardian_view/src/video/presention/cubit/post_upload_cubit.dart';
import 'package:guardian_view/src/video/presention/cubit/video_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  sl.registerSingleton(MyNavigatorObserver());
  sl.registerLazySingleton(() => DialogService());
  await _initApp();
  await _onBoardingInit();
  await _authInit();
  await _AlertsInit();
  await _VideosInit();
}

Future<void> _initApp() async {
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

Future<void> _AlertsInit() async {
  sl
    ..registerLazySingleton(() => AlertCubit(getAlertsUS: sl()))
    ..registerLazySingleton(() => GetAlertsUS(sl()))
    ..registerLazySingleton<AlertRepo>(() => RepoAlertImpl(sl()))
    ..registerLazySingleton<DataSourceAlert>(
        () => DataSourceAlertMyImpl(firestore: sl()));
}

Future<void> _VideosInit() async {
  sl
    ..registerLazySingleton(() => VideoCubit(addVideoDataUS: sl()))
    ..registerLazySingleton(
        () => PostUploadCubit(videoCubit: sl(), postUploadUS: sl()))
    ..registerLazySingleton(() => AddVideoDataUS(sl()))
    ..registerLazySingleton(() => PostUploadUS(sl()))
    ..registerLazySingleton<VideoRepo>(() => RepoVideoImpl(sl()))
    ..registerLazySingleton<DataSourceVideo>(
        () => DataSourceVideoMyImpl(firestore: sl(), firebaseStorage: sl()));
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
