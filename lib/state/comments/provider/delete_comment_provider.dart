import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/comments/notifier/delete_comment_notifier.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/typedefs/is_loading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier,IsLoading>((ref) => DeleteCommentNotifier());
