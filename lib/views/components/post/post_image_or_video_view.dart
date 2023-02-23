import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/models/file_types.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_image_view.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_video_view.dart';

class PostImageOrVideoView extends StatelessWidget {
  const PostImageOrVideoView({required this.post,super.key});
  final Post post;
  @override
  Widget build(BuildContext context) {
     switch (post.fileType) {
      case FileType.video:
        return  PostVideoView(post: post,);
        
        case FileType.image:
        return  PostImageView(post: post);
      default:
      return const SizedBox();
    }
  }
}
