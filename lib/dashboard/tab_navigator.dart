import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    _stackNavigate.add(_initialPage);
  }

  final TabItem _initialPage;
  final List<TabItem> _stackNavigate = [];

  TabItem get currentPage => _stackNavigate.last;
  void push(TabItem item) {
    _stackNavigate.add(item);
    notifyListeners();
    _dPrint();
  }

  void pop() {
    if (_stackNavigate.length > 1) _stackNavigate.removeLast();
    notifyListeners();
    _dPrint();
  }

  void popToRoot() {
    _stackNavigate
      ..clear()
      ..add(_initialPage);
    notifyListeners();
    _dPrint();
  }

  void popTo(TabItem page) {
    _stackNavigate.remove(page);
    notifyListeners();
    _dPrint();
  }

  void popUntil(TabItem? page) {
    if (page == null || _stackNavigate.length == 1) return popToRoot();
    if (_stackNavigate.length > 1) {
      _stackNavigate.removeRange(1, _stackNavigate.indexOf(page) + 1);
      notifyListeners();
      _dPrint();
    }
  }

  void pushAndRemoveUntil(TabItem page) {
    _stackNavigate
      ..clear()
      ..add(page);
    notifyListeners();
    _dPrint();
  }

  void _dPrint() {
    debugPrint(
        'Tab Navigator Page : ${_initialPage.child.runtimeType}\nTab Navigator Stack : $_stackNavigate\n----------------');
  }
}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider(
      {required super.child, required this.navigator, super.key})
      : super(notifier: navigator);
  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();
  final Widget child;
  final String
      id; // of the tab item to know if a tab is the same as another tab
  @override
  String toString() {
    return '${child.runtimeType}';
  }

  @override
  List<dynamic> get props => [id];
}
