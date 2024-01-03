import 'package:guardian_view/core/common/usecases/usecase.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import '../repos/on_boarding_repo.dart';

class CheckIfUserFirstTimer extends UsecaseWithOutParams<bool> {
  // returning bool..
  const CheckIfUserFirstTimer(this._repo);
  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
