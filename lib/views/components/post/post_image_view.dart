import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';

class PostImageView extends StatelessWidget {
  final Post post;
  const PostImageView({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
