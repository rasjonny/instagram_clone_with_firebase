import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';

class PostThumbnailView extends StatelessWidget {
  const PostThumbnailView({
    required this.onTapped,
    required this.post,
    super.key,
  });
  final Post post;
  final VoidCallback onTapped;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      post.thumbnailUrl,
      fit: BoxFit.cover,
    );
  }
}
