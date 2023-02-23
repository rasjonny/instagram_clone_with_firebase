import 'package:flutter/material.dart';

extension DismissKeyBoard on Widget {
  void disMissKeyBoard() => FocusManager.instance.primaryFocus?.unfocus();
}
