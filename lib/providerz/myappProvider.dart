import 'package:flutter/material.dart';

class MyAppProvider extends ChangeNotifier {
  bool showProg = false;

  void changeProg() {
    showProg = !showProg;
    notifyListeners();
  }

  void changeState() {
    notifyListeners();
  }
}
