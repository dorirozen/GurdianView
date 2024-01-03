import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/enums.dart';
import 'package:rxdart/rxdart.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    checkInitialInternetStatus();
    connectivityStreamSubscription = connectivity.onConnectivityChanged
        .debounceTime(const Duration(seconds: 1))
        .listen(_handleConnectivityChange);
  }

  void checkInitialInternetStatus() async {
    final checkInternetRes = await connectivity.checkConnectivity();
    _handleConnectivityChange(checkInternetRes);
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        debugPrint('WiFi Connection');
        emitInternetStatus(ConnectionType.wifi);
        break;
      case ConnectivityResult.mobile:
        debugPrint('Mobile Connection');
        emitInternetStatus(ConnectionType.mobile);
        break;
      case ConnectivityResult.none:
        debugPrint('No Connection');
        emitInternetStatus(ConnectionType.none);
        break;
      default:
        debugPrint('Unknown Connection Type');
        emitInternetStatus(ConnectionType.none); // Handle other types
    }
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }

  void emitInternetStatus(ConnectionType connectionType) =>
      emit(InternetStatus(connectionType: connectionType));
}
