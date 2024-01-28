import 'package:dartz/dartz.dart';
import 'package:guardian_view/core/error/exceptions.dart';
import 'package:guardian_view/core/error/failures.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/alerts/data/data_sources/remote_data_source.dart';
import 'package:guardian_view/src/alerts/domain/entities/alert_entity.dart';
import 'package:guardian_view/src/alerts/domain/repo_alert/repo_alert.dart';

class RepoAlertImpl implements AlertRepo {
  final DataSourceAlert _dataSourceAlert;
  RepoAlertImpl(this._dataSourceAlert);

  @override
  ResultFuture<Stream<List<Alert>>> getAlerts() async {
    try {
      final res = await _dataSourceAlert.getAlerts();
      return Right(res);
    } on ServerException catch (e) {
      throw Left(ServerFailure.fromException(e));
    }
  }
}
