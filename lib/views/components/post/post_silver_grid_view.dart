import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_clone_with_firebase/views/post_details/post_details_view.dart';

import '../../../state/posts/models/post.dart';

class PostSliverGridview extends StatelessWidget {
  const PostSliverGridview({required this.posts,super.key});
  final Iterable<Post> posts;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
delegate: SliverChildBuilderDelegate(childCount: posts.length,(((context, index) {
  final post = posts.elementAt(index);
          return PostThumbnailView(
              post: post,
              onTapped: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return PostDetailsView(
                        post: post,
                      );
                    },
                  ),
                );
              });
        
}))),
        
    );
  }
}
