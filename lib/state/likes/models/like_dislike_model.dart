import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

@immutable
class LikeDisLikeRequest {
  final PostId postId;
  final UserId userId;

  const LikeDisLikeRequest({
    required this.postId,
    required this.userId,
  });
}
