import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/src/alerts/domain/usercases/get_alerts_ui.dart';
import 'package:guardian_view/src/alerts/presention/cubit/alert_state.dart';
import 'package:rxdart/rxdart.dart';

class AlertCubit extends Cubit<AlertState> {
  AlertCubit({required GetAlertsUS getAlertsUS})
      : _getAlertsUS = getAlertsUS,
        super(const AlertStateInitial()) {
    emit(const AlertStateLoading());
    if (!_isStreamInitialized) {
      getAlerts();
    }
  }
  final GetAlertsUS _getAlertsUS;
  StreamSubscription? _alertsSubscription;
  bool _isStreamInitialized = false;

  void getAlerts() async {
    final res = await _getAlertsUS();
    res.fold(
      (failure) => emit(AlertStateError(message: failure.errorMessage)),
      (alertsStream) {
        _alertsSubscription?.cancel(); // Cancel any existing subscription
        _alertsSubscription =
            alertsStream.debounceTime(const Duration(seconds: 1)).listen(
          //cancelOnError: false,
          (alerts) {
            emit(AlertStateLoaded(
                alertsList: alerts)); // Emit loaded state with list of alerts
          },
          onError: (error) {
            emit(
                AlertStateError(message: error.toString())); // Emit error state
          },
        );
        _isStreamInitialized = true;
      },
    );
  }

// Method to check if the stream is initialized
  bool checkStreamInitialized() {
    debugPrint('stream checked if initilized from cubit');
    return _isStreamInitialized;
  }

  // Method to pause the subscription
  void pauseSubscription() {
    debugPrint('app paused from cubit');
    if (_isStreamInitialized && _alertsSubscription != null) {
      _alertsSubscription?.pause();
    }
  }

  // Method to resume the subscription
  void resumeSubscription() {
    debugPrint('app resumed from cubit');
    if (_isStreamInitialized && _alertsSubscription != null) {
      _alertsSubscription?.resume();
    }
  }

  // Override close to cancel the subscription and update the flag
  @override
  Future<void> close() {
    debugPrint('app disposed from cubit');
    _alertsSubscription?.cancel();
    _isStreamInitialized = false;
    return super.close();
  }
}
