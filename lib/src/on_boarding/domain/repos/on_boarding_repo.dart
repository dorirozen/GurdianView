
import 'package:guardian_view/core/typedefs/typedef.dart';

abstract class OnBoardingRepo {
  const OnBoardingRepo();
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
