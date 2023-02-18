import 'package:flutter/foundation.dart' show immutable;

@immutable
class Constants {
  const Constants._();
  static const allowLikesTitle = 'Allow likes';
  static const comments = 'comments';
  static const allowLikesDescription =
      'by allowing likes, users will be able to press the like button on your post.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'by allowing comments, users will be able to comment on your post';
  static const allowCommentsStoragKey = 'allow_comments';
}
