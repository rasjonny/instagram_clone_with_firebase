import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends HookWidget {
  final Post post;
  const PostVideoView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = VideoPlayerController.network(post.fileUrl);
    final isVideoPlayer = useState(false);
    useEffect(() {
      controller.initialize().then((value) {
        isVideoPlayer.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose;
    }, [controller]);
    switch (isVideoPlayer.value) {
      case true:
        return AspectRatio(
          aspectRatio: post.aspectRatio,
          child: VideoPlayer(controller),
        );
      case false:
        return const LoadingAnimationView();
      default:
        return const ErrorAnimationView();
    }
    
  }
}
