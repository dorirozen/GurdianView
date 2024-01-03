part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InternetLoading extends InternetState {}

class InternetStatus extends InternetState {
  final ConnectionType connectionType;
  InternetStatus({required this.connectionType});
  @override
  List<Object?> get props => [connectionType];
}
