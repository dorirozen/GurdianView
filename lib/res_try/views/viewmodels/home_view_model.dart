import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  String title = 'default';
  int counter = 0;
  void initialize() {
    title = 'initilized';
    notifyListeners();
  }

  void updateTitle() {
    counter++;
    title = 'Updated: $counter';
    notifyListeners();
  }
}
