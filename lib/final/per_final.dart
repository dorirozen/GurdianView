import 'package:flutter/material.dart';
import 'package:guardian_view/final/tab_final.dart';
import 'package:provider/provider.dart';

class PersistentViewFinal extends StatefulWidget {
  const PersistentViewFinal({super.key, this.body});
  final Widget? body;
  @override
  State<PersistentViewFinal> createState() => _PersistentViewFinalState();
}

class _PersistentViewFinalState extends State<PersistentViewFinal>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // context.watch<TabNavigator>() = go up the widget tree , find me the closest tabNavigator
    return widget.body ?? context.watch<TabNavigatorFinal>().currentPage.child;
  }

  @override
  bool get wantKeepAlive => true;
}
