import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/views/components/rich_text/base_text.dart';
import 'package:instagram_clone_with_firebase/views/components/rich_text/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;
  const RichTextWidget({
    required this.texts,
    this.styleForAll,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.textStyle),
              recognizer: TapGestureRecognizer()..onTap =baseText.onTapped, );
          } else {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.textStyle),
            );
          }
        }).toList(),
      ),
    );
  }
}
