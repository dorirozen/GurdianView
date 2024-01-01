import 'package:flutter/material.dart';
import 'package:guardian_view/core/common/app/providers/tab_navigator.dart';
import 'package:guardian_view/core/common/app/providers/user_provider.dart';
import 'package:guardian_view/src/auth/domain/entites/local_user.dart';
import 'package:provider/provider.dart';

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

  UserProvider get userProvider => read<UserProvider>();

  /// here we use the entity [ LocalUser ]!!!
  LocalUser? get currentUser => userProvider.user;
}
