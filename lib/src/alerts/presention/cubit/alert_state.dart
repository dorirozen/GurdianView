import 'package:equatable/equatable.dart';
import 'package:guardian_view/src/alerts/domain/entities/alert_entity.dart';

abstract class AlertState extends Equatable {
  const AlertState();
  @override
  List<Object?> get props => [];
}

///basics
class AlertStateInitial extends AlertState {
  const AlertStateInitial();
}

class AlertStateError extends AlertState {
  const AlertStateError({required this.message});
  final String message;
}

///basics

class AlertStateLoading extends AlertState {
  const AlertStateLoading();
}

class AlertStateLoaded extends AlertState {
  const AlertStateLoaded({required this.alertsList});
  final List<Alert> alertsList;
  @override
  List<Object?> get props => [alertsList];
}
