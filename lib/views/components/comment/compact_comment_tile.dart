import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/comments_model.dart';
import 'package:instagram_clone_with_firebase/state/user_info/providers/user_info_providers.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/small_error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/post/rich_two_part.dart';

class CompactCommentTile extends ConsumerWidget {
  const CompactCommentTile({required this.comment, super.key});
  final CommentsModel comment;
  @override
  Widget build(BuildContext context, ref) {
    final userInfo = ref.watch(userInfoProviders(comment.fromUserId));
   return userInfo.when(
        data: (info) {
          return RichTwoPart(left: info.displayName, right: comment.comments);
        },
        error: (((error, stackTrace) => const SmallErrorAnimationView())),
        loading: () => const LoadingAnimationView());
  }
}
