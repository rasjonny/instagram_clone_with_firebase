import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/comments/typedefs/commetns.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

@immutable
class CommentsModel {
  final String comments;
  final CommentId id;
  final PostId postId;
  final DateTime createdAt;
  final UserId fromUserId;
  CommentsModel({
    required Map<String, dynamic> json,
    required this.id,
  })  : comments = json[FirebaseFieldNames.comment],
        postId = json[FirebaseFieldNames.postId],
        createdAt = (json[FirebaseFieldNames.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldNames.userId];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentsModel &&
          runtimeType == other.runtimeType &&
          fromUserId == other.fromUserId &&
          comments == other.comments &&
          id == other.id &&
          createdAt == other.createdAt &&
          postId == other.postId;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll([
        createdAt,
        comments,
        fromUserId,
        id,
        postId,
      ]);
}
