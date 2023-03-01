import 'package:collection/collection.dart' show IterableEquality;
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/comments/models/comments_model.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';

@immutable
class PostWithComment {
  final Iterable<CommentsModel> comments;
  final Post post;

  const PostWithComment({
    required this.comments,
    required this.post,
  });
  @override
  bool operator ==(covariant PostWithComment other) =>
      post == other.post &&
      const IterableEquality().equals(comments, other.comments);

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll([comments, post]);
}
