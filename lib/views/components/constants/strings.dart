import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  const Strings._();
  static const allowLikesTitle = 'Allow likes';
  static const comments = 'comments';
  static const allowLikesDescription =
      'by allowing likes, users will be able to press the like button on your post.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'by allowing comments, users will be able to comment on your post';
  static const allowCommentsStoragKey = 'allow_comments';
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';
  static const loading = 'loading...';
  static const delete = 'delete';
  static const areYouSureYouWantToDeleteThis =
      'are you sure you want to delete this?';
  static const logout = 'logout';
  static const areYouSureYouWantToLogoutOfTheApp =
      'are you sure you want to logout of the app?';
  static const cancel = 'Cancel';
}
