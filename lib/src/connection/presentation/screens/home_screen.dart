import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.title, this.color});

  final String? title;
  final Color? color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetStatus &&
                    state.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Wi-Fi',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green,
                        ),
                  );
                } else if (state is InternetStatus &&
                    state.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.red,
                        ),
                  );
                } else if (state is InternetStatus &&
                    state.connectionType == ConnectionType.none) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  );
                }
                return Text('${state.toString()}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
