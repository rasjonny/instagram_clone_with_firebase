import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RichTwoPart extends StatelessWidget {
  final String left;
  final String right;
  const RichTwoPart({required this.left, required this.right, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: const TextStyle(color: Colors.white70, height: 1.5),
          children: [
            TextSpan(
                text: left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
              text: ' $right',
            ),
          ]),
    );
  }
}
