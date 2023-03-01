import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

class Like extends MapView<String, String> {
  final PostId postId;
  final UserId likedby;
  final DateTime dateTime;

  Like({
    required this.postId,
    required this.likedby,
    required this.dateTime,
  }) : super({FirebaseFieldNames.postId:postId,
  FirebaseFieldNames.date:dateTime.toIso8601String(),
  FirebaseFieldNames.userId:likedby});
}
