import 'package:flutter/cupertino.dart';

class NavigatorProvider extends ChangeNotifier {
  int _navigationIndex = 0;
  int get navigationIndex => _navigationIndex;
  set navigationIndex(int value) {
    _navigationIndex = value;
    notifyListeners();
  }
}
