import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/comments_model.dart';
import 'package:instagram_clone_with_firebase/state/comments/provider/delete_comment_provider.dart';
import 'package:instagram_clone_with_firebase/state/user_info/providers/user_info_providers.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/constants/strings.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/delete_dialogue.dart';

class CommentTile extends ConsumerWidget {
  const CommentTile({required this.comment, super.key});
  final CommentsModel comment;
  @override
  Widget build(BuildContext context, ref) {
    final userInfo = ref.watch(
      userInfoProviders(comment.fromUserId),
    );
   return userInfo.when(
        data: (userInfo) {
          return ListTile(title: Text(userInfo.displayName,),subtitle: Text(comment.comments),
            trailing: userInfo.userId == comment.fromUserId
                ? IconButton(
                    onPressed: () async {
                      final shouldDelete = await deleteCommentDialogue(context);
                      if (shouldDelete) {
                        await ref
                            .read(deleteCommentProvider.notifier)
                            .deleteComment(commentId: comment.id);
                      }
                    },
                    icon: const Icon(Icons.delete),
                  )
                : null,
          );
        },
        error: (e, s) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView());
  }
}

Future<bool> deleteCommentDialogue(BuildContext context) {
  return DeleteDialogue(
    titleObjectToDelete: Strings.comments,
  ).present(context).then((value) => value ?? false);
}
