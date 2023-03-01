import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/auth_state_providers.dart';
import 'package:instagram_clone_with_firebase/state/comments/provider/delete_comment_provider.dart';
import 'package:instagram_clone_with_firebase/state/comments/provider/send_comment_provider.dart';
import 'package:instagram_clone_with_firebase/state/posts/providers/delete_post_provider.dart';

import '../image_upload/providers/image_upload_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final imageUpload = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingCommetnt= ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  
  final isLoading = authState.isLoading;
  return isLoading || imageUpload || isSendingComment || isDeletingPost || isDeletingCommetnt;
});
