import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';

final hasLikedProvider =
    StreamProvider.family.autoDispose<bool, PostId>((ref, PostId postId) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<bool>();
  if (userId == null) {
    return Stream.value(false);
  }

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.likes)
      .where(FirebaseFieldNames.userId, isEqualTo: userId)
      .where(FirebaseFieldNames.postId, isEqualTo: postId)
      .snapshots()
      .listen((snapshot) {
    final docs = snapshot.docs;
    if (docs.isNotEmpty) {
      controller.sink.add(true);
    }
    controller.sink.add(false);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
