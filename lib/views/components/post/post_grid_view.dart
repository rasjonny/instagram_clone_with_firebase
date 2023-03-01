import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_thumbnail_view.dart';
import 'package:instagram_clone_with_firebase/views/post_details/post_details_view.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({required this.posts, super.key});
  final Iterable<Post> posts;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
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
        });
  }
}
