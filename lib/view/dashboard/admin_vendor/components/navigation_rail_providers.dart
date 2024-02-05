import 'package:flutter/material.dart';

class NavigationRailProvider with ChangeNotifier {
  int _selectedIndex = 0;
  get selectedIndex => _selectedIndex;
  void selectindex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
