import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardian_view/core/services/getit/injection_container.main.dart';
import 'package:guardian_view/src/alerts/presention/cubit/alert_cubit.dart';
import 'package:guardian_view/src/alerts/presention/cubit/alert_state.dart';

/// here i want to retrieve data and show it .
/// like i did with [ AlertListPage Class ].
class AlertsWidget extends StatefulWidget {
  const AlertsWidget({super.key});

  @override
  State<AlertsWidget> createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<AlertsWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    debugPrint('initilize');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    debugPrint('disposed');
    WidgetsBinding.instance.removeObserver(this);
    if (sl.isRegistered<AlertCubit>()) {
      final alertCubit = sl<AlertCubit>();
      if (alertCubit.checkStreamInitialized()) {
        alertCubit.close(); // Resume the paused subscription
      }
    }
    debugPrint('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: BlocBuilder<AlertCubit, AlertState>(
              builder: (context, state) {
                if (state is AlertStateInitial) {
                  debugPrint('here');
                  return Text('Welcome to Alerts');
                }
                if (state is AlertStateLoading) {
                  return const CircularProgressIndicator(
                    color: Colors.black26,
                  );
                } else if (state is AlertStateLoaded) {
                  return state.alertsList.length == 0
                      ? Text('empty')
                      : SizedBox(
                          height: 500,
                          child: ListView.builder(
                            itemCount: state.alertsList.length,
                            itemBuilder: (context, index) {
                              final alert = state.alertsList[index];
                              return ListTile(
                                title: Text(
                                  alert.id,
                                  style: TextStyle(
                                      color: Colors.black26, fontSize: 25),
                                ),
                                // ... other properties ...
                              );
                            },
                          ),
                        );
                } else if (state is AlertStateError) {
                  return Text(
                    'Error: ${state.message}',
                    style: TextStyle(color: Colors.black26, fontSize: 25),
                  );
                } else {
                  return Text(
                    'Unexpected state',
                    style: TextStyle(color: Colors.black26, fontSize: 25),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
