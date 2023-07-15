import 'package:flutter/material.dart';

class MasterValueController<T> extends ChangeNotifier {
  T? value;
  String? text;

  void setValue(T? value) {
    this.value = value;
    notifyListeners();
  }

  void setText(String? value) {
    this.text = value;
    notifyListeners();
  }
}
