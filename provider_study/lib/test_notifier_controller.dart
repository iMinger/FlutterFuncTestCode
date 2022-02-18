

import 'package:flutter/cupertino.dart';

class TestNotifierController extends ChangeNotifier {
  String _value = '0';
  String get value => _value;

  set value(String newValue) {
    if (_value == newValue) return;
    _value = newValue;

    /// 通知外部所有使用了TestNotifierController的地方进行值刷新。
    notifyListeners();
  }
}