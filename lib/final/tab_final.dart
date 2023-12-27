import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigatorFinal extends ChangeNotifier {
  TabNavigatorFinal(this._initialPage) {
    _stackNavigate.add(_initialPage);
  }

  final TabItemFinal _initialPage;
  final List<TabItemFinal> _stackNavigate = [];

  TabItemFinal get currentPage => _stackNavigate.last;
  void push(TabItemFinal item) {
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

  void popTo(TabItemFinal page) {
    _stackNavigate.remove(page);
    notifyListeners();
    _dPrint();
  }

  void popUntil(TabItemFinal? page) {
    if (page == null || _stackNavigate.length == 1) return popToRoot();
    if (_stackNavigate.length > 1) {
      _stackNavigate.removeRange(1, _stackNavigate.indexOf(page) + 1);
      notifyListeners();
      _dPrint();
    }
  }

  void pushAndRemoveUntil(TabItemFinal page) {
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

class TabNavigatorProvider1 extends InheritedNotifier<TabNavigatorFinal> {
  const TabNavigatorProvider1(
      {required super.child, required this.navigator, super.key})
      : super(notifier: navigator);
  final TabNavigatorFinal navigator; // thats what he will return for us .

  static TabNavigatorFinal? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider1>()
        ?.navigator;
  }
}

class TabItemFinal extends Equatable {
  TabItemFinal({required this.child}) : id = const Uuid().v1();
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
