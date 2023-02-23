import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/request_post_comment.dart';
import 'package:instagram_clone_with_firebase/state/comments/provider/post_comment_provider.dart';
import 'package:instagram_clone_with_firebase/state/comments/provider/send_comment_provider.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/empty_content_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/comment/comment_tile.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';
import 'package:instagram_clone_with_firebase/views/extension/dismiss_keyboard.dart';

class PostCommentView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentView({required this.postId, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(RequestPostAndComment(postId: postId));

    final comments = ref.watch(postCommentProvider(request.value));
    useEffect(() {
      commentsController.addListener(() {
        hasText.value = commentsController.text.isNotEmpty;
      });
      return () {};
    }, [commentsController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
              onPressed: hasText.value
                  ? () async {
                      _submitCommentController(
                          controller: commentsController, ref: ref);
                    }
                  : null,
              icon: const Icon(Icons.send))
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) {
                  if (comments.isEmpty) {
                    return const EmptyContentWithTextAnimationView(
                        text: Strings.noCommentsYet);
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.refresh(postCommentProvider(request.value));
                      return Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: comments.length,
                        itemBuilder: ((context, index) {
                          final comment = comments.elementAt(index);
                          return CommentTile(comment: comment);
                        })),
                  );
                },
                error: (s, e) => const ErrorAnimationView(),
                loading: () => const LoadingAnimationView(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: commentsController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentController(
                            controller: commentsController, ref: ref);
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type your comment here'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentController({
    required TextEditingController controller,
    required WidgetRef ref,
  }) async {
    final userId = ref.read(userIdProvider) ?? '';
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          postId: postId,
          userId: userId,
          comment: controller.text,
        );
    if (isSent) {
      controller.clear();
      disMissKeyBoard();
    }
  }
}
