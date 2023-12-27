import 'package:flutter/material.dart';
import 'package:guardian_view/dashboard/persistent_view.dart';
import 'package:guardian_view/dashboard/tab_navigator.dart';
import 'package:provider/provider.dart';

import '../temp.dart';

class DashBoardController extends ChangeNotifier {
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: HomePage1(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: HomePage1(),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: HomePage1(), //HomeView(),
        ),
      ),
      child:
          const PersistentView(), //remember ! we didnt pass any body so it will watch
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: HomePage1(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];
  List<int> _indexHistory = [0];
  int _currentIndex = 3;

  List<Widget> get screens => _screens;
  int get currentIndex => _currentIndex;
  void _dPrint(int a) {
    debugPrint(
        'Trying To Nav From ${_currentIndex.toString()} To Nav ${a.toString()}');
  }

  void changeIndex(int index) {
    _dPrint(index);
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 3;
    notifyListeners();
  }

  @override
  String toString() {
    return '$_currentIndex';
  }
}
