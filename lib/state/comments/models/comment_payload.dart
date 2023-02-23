import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

@immutable
class CommentPayLoad extends MapView<String, dynamic> {
  final UserId userId;
  final PostId postId;
  final String comment;

  CommentPayLoad({
    required this.userId,
    required this.postId,
    required this.comment,
  }) : super({FirebaseFieldNames.userId:userId,
  FirebaseFieldNames.postId:postId,
  FirebaseFieldNames.comment:comment,
  FirebaseFieldNames.createdAt:FieldValue.serverTimestamp(),});
}
