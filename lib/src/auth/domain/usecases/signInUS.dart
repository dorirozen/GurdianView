import 'package:equatable/equatable.dart';
import 'package:guardian_view/core/common/usecases/usecase.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/auth/domain/entites/local_user.dart';
import 'package:guardian_view/src/auth/domain/repos/auth_repo.dart';

class SignInUS extends UsecaseWithParams<LocalUser, SignInParams> {
  const SignInUS(this._authRepo);
  final AuthRepo _authRepo;
  @override
  ResultFuture<LocalUser> call(SignInParams params) =>
      _authRepo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;

  const SignInParams.empty()
      : email = '',
        password = '';

  @override
  List<Object?> get props => [email, password];
}
