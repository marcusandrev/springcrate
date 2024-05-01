import 'package:flutter/material.dart';

class EmployeeUtils {
  static String getActionText(int status) {
    return status == 0 ? 'Activate' : 'Deactivate';
  }

  static Color getActionColor(int status) {
    return status == 0 ? Colors.green : Colors.red;
  }

  static String stringifyRate(double rate) {
    return rate == 0.4 ? '60/40' : '70/30';
  }
}
