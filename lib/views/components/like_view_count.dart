import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/likes/providers/like_count_provider.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/constants/strings.dart';

class LikeViewCountView extends ConsumerWidget {
  const LikeViewCountView({required this.postId, super.key});
  final PostId postId;
  @override
  Widget build(BuildContext context, ref) {
    final likeCount = ref.watch(postsLikecountProvider(postId));
    return likeCount.when(
        data: (int count) {
          final personPeople = count == 1 ? 'Person' : 'People';
          final likesText = '$likeCount $personPeople ${Strings.likedThis}';
          return Text(likesText);
        },
        error: (s, e) => const ErrorAnimationView(),
        loading: () {
          return const LoadingAnimationView();
        });
  }
}
