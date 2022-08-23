import 'dart:async';

import 'package:flutter/material.dart';

class TimerSecond extends ChangeNotifier {
  Timer? _timer;

  void cancleTimer() {
    _timer?.cancel();
  }

  void startTimer() {
    print("Start");
    _second = 90;
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_second == 0) {
        timer.cancel();
        notifyListeners();
      } else {
        _second--;
        notifyListeners();
      }
    });
  }

  int _second = 90;
  int? get second => _second;
}
