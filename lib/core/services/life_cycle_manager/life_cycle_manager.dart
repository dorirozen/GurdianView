import 'package:flutter/material.dart';

/// how to use - marks in "[]"
/*
class MyCustomWidget extends [ BaseLifecycleWidget ] {
  const MyCustomWidget({Key? key}) : super(key: key);

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends [ BaseLifecycleState ]<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    // Build your widget here
    return Container(); // Replace with your widget's layout
  }

  @override
  void onInit() {
    // Initialization logic specific to MyCustomWidget
  }

  @override
  void onDispose() {
    // Dispose logic specific to MyCustomWidget
  }

  @override
  void onResume() {
    // Code to execute when app resumes and this widget is visible
  }

  @override
  void onPause() {
    // Code to execute when app pauses and this widget is visible
  }
}

 */
abstract class BaseLifecycleWidget extends StatefulWidget {
  const BaseLifecycleWidget({Key? key}) : super(key: key);

  @override
  BaseLifecycleState createState();
}

abstract class BaseLifecycleState<T extends BaseLifecycleWidget>
    extends State<T> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint('initilize widget of type: ${widget.runtimeType}');
    onInit();
  }

  @override
  void dispose() {
    onDispose();
    debugPrint('Disposing widget of type: ${widget.runtimeType}');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.hidden:
        onHidden();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPause();
        break;
      case AppLifecycleState.resumed:
        onResume();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      default:
        break;
    }
  }

  // Custom lifecycle methods that can be overridden in subclasses
  void onInit() {}
  void onDispose() {}
  @mustCallSuper
  void onResume() => debugPrint('Resume widget of type: ${widget.runtimeType}');
  @mustCallSuper
  void onPause() => debugPrint('Pause widget of type: ${widget.runtimeType}');
  @mustCallSuper
  void onHidden() => debugPrint('Hidden widget of type: ${widget.runtimeType}');
  @mustCallSuper
  void onInactive() =>
      debugPrint('Inactive widget of type: ${widget.runtimeType}');
  @mustCallSuper
  void onDetached() =>
      debugPrint('Detached widget of type: ${widget.runtimeType}');
}
