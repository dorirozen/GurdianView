import 'package:dartz/dartz.dart';
import 'package:guardian_view/core/enums/update_user.dart';
import 'package:guardian_view/core/error/exceptions.dart';
import 'package:guardian_view/core/error/failures.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/auth/domain/entites/local_user.dart';
import 'package:guardian_view/src/auth/domain/repos/auth_repo.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<LocalUser> signIn(
      {required String email, required String password}) async {
    try {
      final res =
          await _remoteDataSource.signIn(email: email, password: password);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      await _remoteDataSource.signUp(
          email: email, fullName: fullName, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser(
      {required UpdateUserAction action, userData}) async {
    try {
      await _remoteDataSource.updateUser(action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
