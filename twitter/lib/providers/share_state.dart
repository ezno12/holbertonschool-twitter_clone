import 'package:flutter/material.dart';

class SharedState extends ChangeNotifier {
  bool _hasChanged = false;
  bool get isbusy => _hasChanged;
  set loading(bool value) {
    _hasChanged = value;
    notifyListeners();
  }
  int _pageNum = 0;
  int get pageNum {
    return _pageNum;
  }
  set setpageIndex(int index) {
    _pageNum = index;
    notifyListeners();
  }
}
