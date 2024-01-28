import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  const BaseWidget(
      {super.key,
      required this.child,
      required this.initilizeState,
      required this.create});

  final Widget Function(BuildContext) child;
  final Function(T)? initilizeState;
  final T create;

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T? _instance;
  @override
  void initState() {
    super.initState();
    _instance = widget.create;
    if (widget.initilizeState != null && _instance != null) {
      widget.initilizeState!(_instance!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _instance,
      child: widget.child(context),
    );
  }
}
