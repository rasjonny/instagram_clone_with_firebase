import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/models/lottie_animations.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationsWidget extends StatelessWidget {
  const LottieAnimationsWidget({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });
  final bool reverse;
  final bool repeat;
  final LottieAnimations animation;
  @override
  Widget build(BuildContext context) => Lottie.asset(animation.getFullPath);
}

extension GetFullPath on LottieAnimations {
  String get getFullPath => 'assets/animations/$name.json';
}
