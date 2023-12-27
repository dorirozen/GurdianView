import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'final/tab_final.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  // instead of Theme.of(context) -> context.theme

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  TabNavigatorFinal get tabNavigator => read<TabNavigatorFinal>();
  void pop() => tabNavigator.pop();
  void push(Widget page) => tabNavigator.push(TabItemFinal(child: page));
  void popToRoot() => tabNavigator.popToRoot();
  //void pushAndRemoveUntil(Widget page) => tabNavigator.pushAndRemoveUntil(TabItem(child: page));
}
