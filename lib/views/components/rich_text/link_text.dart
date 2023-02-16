
import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/views/components/rich_text/base_text.dart';

class LinkText extends BaseText {
  final VoidCallback onTapped;

  const LinkText({
    required super.text,
    required this.onTapped,
     super.textStyle,
  });
}
