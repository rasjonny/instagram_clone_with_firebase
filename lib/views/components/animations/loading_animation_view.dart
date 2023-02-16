import 'package:instagram_clone_with_firebase/views/components/animations/lottie_animations_widget.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/models/lottie_animations.dart';

class LoadingAnimationView extends LottieAnimationsWidget {
  const LoadingAnimationView({super.key})
      : super(animation: LottieAnimations.loading);
}