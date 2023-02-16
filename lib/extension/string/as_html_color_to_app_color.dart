import 'package:flutter/material.dart' show Color;
import 'package:instagram_clone_with_firebase/extension/string/remove_all.dart';

extension AsHtmlColorToAppColor on String {
  Color htmlColorToColor() =>
      Color(int.parse(removeAll(['0x', '#']).padLeft(8, 'ff'), radix: 16));
}
