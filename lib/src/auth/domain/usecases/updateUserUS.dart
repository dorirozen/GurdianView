import 'package:equatable/equatable.dart';
import 'package:guardian_view/core/common/usecases/usecase.dart';
import 'package:guardian_view/core/enums/update_user.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/auth/domain/repos/auth_repo.dart';

class UpdateUserUS extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUserUS(this._authRepo);
  final AuthRepo _authRepo;
  @override
  ResultFuture<void> call(UpdateUserParams params) =>
      _authRepo.updateUser(action: params.action, userData: params.userData);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});
  final UpdateUserAction action;
  final dynamic userData;

  const UpdateUserParams.empty()
      : action = UpdateUserAction.displayName,
        userData = '';

  @override
  List<Object?> get props => [action, userData];
}
