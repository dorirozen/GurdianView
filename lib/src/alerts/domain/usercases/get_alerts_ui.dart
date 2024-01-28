import 'package:guardian_view/core/common/usecases/usecase.dart';
import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/alerts/domain/entities/alert_entity.dart';
import 'package:guardian_view/src/alerts/domain/repo_alert/repo_alert.dart';

class GetAlertsUS implements UsecaseWithOutParams<Stream<List<Alert>>> {
  final AlertRepo _alertRepo;
  const GetAlertsUS(this._alertRepo);

  @override
  ResultFuture<Stream<List<Alert>>> call() => _alertRepo.getAlerts();
}
