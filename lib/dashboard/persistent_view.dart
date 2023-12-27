import 'package:flutter/material.dart';
import 'package:guardian_view/dashboard/tab_navigator.dart';

import 'package:provider/provider.dart';

class PersistentView extends StatefulWidget {
  const PersistentView({super.key, this.body});
  final Widget? body;
  @override
  State<PersistentView> createState() => _PersistentViewState();
}

class _PersistentViewState extends State<PersistentView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // context.watch<TabNavigator>() = go up the widget tree , find me the closest tabNavigator
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  @override
  bool get wantKeepAlive => true;
}
