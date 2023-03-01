import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_with_firebase/state/likes/models/like_dislike_model.dart';
import 'package:instagram_clone_with_firebase/state/likes/providers/has_liked_provider.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/small_error_animation_view.dart';

import '../../state/likes/providers/like_dislike_provider.dart';
import '../../state/posts/typedefs/post_id.dart';

class LikeButton extends ConsumerWidget {
  const LikeButton({required this.postId, super.key});
  final PostId postId;
  @override
  Widget build(BuildContext context, ref) {
    final userId = ref.read(userIdProvider);
    final hasLiked = ref.watch(hasLikedProvider(postId));
    return hasLiked.when(
        data: ((liked) {
          {
            return IconButton(
                onPressed: () {
                  if (userId == null) {
                    return;
                  }
                  final likeDisLikeRequest =
                      LikeDisLikeRequest(postId: postId, userId: userId);
                  
                      ref.read(likeDislikePostProvider(likeDisLikeRequest));
                },
                icon: FaIcon(liked
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart));
          }
        }),
        error: (((error, stackTrace) => const SmallErrorAnimationView())),
        loading: () => const LoadingAnimationView());
  }
}
