import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard/tab_navigator.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  // instead of Theme.of(context) -> context.theme
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  TabNavigator get tabNavigator => read<TabNavigator>();
  void pop() => tabNavigator.pop();
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
  void popToRoot() => tabNavigator.popToRoot();
}
