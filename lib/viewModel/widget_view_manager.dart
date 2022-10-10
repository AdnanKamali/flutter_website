import 'package:flutter/material.dart';

class WidgetManager extends ChangeNotifier {
  bool _isClickedContinue = false;
  bool get isClickedContinue => _isClickedContinue;
  void clickCotinue(bool isClicked) {
    _isClickedContinue = isClicked;
    notifyListeners();
  }
}
