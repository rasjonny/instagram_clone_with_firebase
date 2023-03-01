import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/enums/date_sorting.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/request_post_comment.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_clone_with_firebase/state/posts/providers/delete_post_provider.dart';
import 'package:instagram_clone_with_firebase/state/posts/providers/specific_post_with_comment_provider.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/comment/compact_column_comment.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_with_firebase/views/components/dialogs/delete_dialogue.dart';
import 'package:instagram_clone_with_firebase/views/components/like_button.dart';
import 'package:instagram_clone_with_firebase/views/components/like_view_count.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_date_view.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_displayname_and_message.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_image_or_video_view.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';
import 'package:instagram_clone_with_firebase/views/post_comment/post_comment_view.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  const PostDetailsView({required this.post, super.key});
  final Post post;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final request = RequestPostAndComment(
      postId: widget.post.postId,
      limit: 3,
      dateSorting: DateSorting.oldestOnTop,
    );
    final postWithComment = ref.watch(specificPostWithCommentProvider(request));
    final canDeletePost =
        ref.watch(canCurrentUserDeletePostProvider(widget.post));
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          postWithComment.when(
            data: (postAndComment) {
              return IconButton(
                onPressed: () {
                  final url = postAndComment.post.fileUrl;
                  Share.share(url, subject: "Check out this post!");
                },
                icon: const Icon(Icons.share),
              );
            },
            error: (error, stackTrace) => const ErrorAnimationView(),
            loading: () => const LoadingAnimationView(),
          ),
          if (canDeletePost.value ?? false)
            IconButton(
              onPressed: () async {
                final shouldDeletPost =
                    await DeleteDialogue(titleObjectToDelete: Strings.post)
                        .present(context);

                if (shouldDeletPost ?? false) {
                  await ref
                      .read(deletePostProvider.notifier)
                      .deletePost(post: widget.post);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: postWithComment.when(
          data: (postWithcomments) {
            final postId = postWithcomments.post.postId;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostImageOrVideoView(
                    post: postWithcomments.post,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (postWithcomments.post.allowLikes)
                        LikeButton(postId: postId),
                      if (postWithcomments.post.allowComments)
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return PostCommentView(
                                    postId: postId,
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.mode_comment_outlined),
                        ),
                    ],
                  ),
                  PostDisplayNameAndMessageView(
                    post: postWithcomments.post,
                  ),
                  PostDateView(
                    dateTime: postWithcomments.post.createdAt,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.white70,
                    ),
                  ),
                  CompactColumnComment(
                    comments: postWithcomments.comments,
                  ),
                  if (postWithcomments.post.allowLikes)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          LikeViewCountView(postId: postId),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          },
          error: (e, s) => const ErrorAnimationView(),
          loading: () => const LoadingAnimationView()),
    );
  }
}
