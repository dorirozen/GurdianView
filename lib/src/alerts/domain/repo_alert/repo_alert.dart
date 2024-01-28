import 'package:guardian_view/core/typedefs/typedef.dart';
import 'package:guardian_view/src/alerts/domain/entities/alert_entity.dart';

abstract class AlertRepo {
  const AlertRepo();
  ResultFuture<Stream<List<Alert>>> getAlerts();
}
