import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';

import '../../image_upload/typedefs/is_loading.dart';

final canCurrentUserDeletePostProvider =
    StreamProvider.family.autoDispose<IsLoading, Post>((ref, Post post) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});
