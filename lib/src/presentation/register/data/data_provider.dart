import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  Map<String, dynamic> _outputData = {};

  Map<String, dynamic> get outputData => _outputData;

  void setOutputData(Map<String, dynamic> data) {
    _outputData = data;
    notifyListeners();
  }
}
