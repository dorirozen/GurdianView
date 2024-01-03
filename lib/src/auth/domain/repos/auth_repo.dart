import 'package:guardian_view/core/enums/update_user.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/auth/domain/entites/local_user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LocalUser> signIn(
      {required String email, required String password});

  ResultFuture<void> signUp(
      {required String email,
      required String fullName,
      required String password});

  ResultFuture<void> updateUser(
      {required UpdateUserAction action, dynamic userData});
}
