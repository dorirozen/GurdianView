import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Check extends StatelessWidget {
  const Check({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          body: Column(children: [
            Container(
              child: Text('hey'),
            )
          ]),
        );
      },
    );
  }
}
