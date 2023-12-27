import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    checkInitialInternetStatus();
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        debugPrint('1');
        emitInternetStatus(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        debugPrint('2');
        emitInternetStatus(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        debugPrint('3');
        emitInternetStatus(ConnectionType.none);
      }
    });
  }
  void checkInitialInternetStatus() async {
    final checkInternetRes = await connectivity.checkConnectivity();
    if (checkInternetRes.name == ConnectivityResult.wifi.name) {
      emitInternetStatus(ConnectionType.Wifi);
    } else if (checkInternetRes.name == ConnectivityResult.mobile.name) {
      debugPrint('2');
      emitInternetStatus(ConnectionType.Mobile);
    } else if (checkInternetRes.name == ConnectivityResult.none.name) {
      debugPrint('3');
      emitInternetStatus(ConnectionType.none);
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
