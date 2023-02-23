import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';

final postsLikecountProvider = StreamProvider.family.autoDispose<int, PostId>(
  (ref, PostId postId) {
    final controller = StreamController<int>.broadcast();
    controller.onListen = () {
      controller.sink.add(0);
    };
    final subs = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.likes).where(FirebaseFieldNames.postId,isEqualTo: postId)
        .snapshots()
        .listen((snapshot) {
      final docs = snapshot.docs;
      final length = docs.length;
      controller.sink.add(length);
    });
    ref.onDispose(() {
      subs.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
