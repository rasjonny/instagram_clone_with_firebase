import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/views/components/rich_text/link_text.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? textStyle;

  const BaseText({
    required this.text,
    this.textStyle,
  });
  factory BaseText.plain({
    required String text,
  }) =>
      BaseText(text: text, textStyle: const TextStyle());
  factory BaseText.linkText({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(
        text: text,
        textStyle: style,
        onTapped: onTapped,
      );
}
