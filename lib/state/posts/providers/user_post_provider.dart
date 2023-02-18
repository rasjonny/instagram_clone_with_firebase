import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post_key.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final controller = StreamController<Iterable<Post>>();
  final userId = ref.watch(userIdProvider);
  controller.onListen = (() {
    controller.sink.add([]);
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.posts)
        .orderBy(FirebaseFieldNames.createdAt, descending: true)
        .where(PostKey.userId == userId)
        .snapshots()
        .listen((event) {
      final documents = event.docs;
      final posts = documents
          .where((element) => !element.metadata.hasPendingWrites)
          .map((e) => Post(postId: e.id, json: e.data()));
      controller.sink.add(posts);
    });
    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
  });
  return controller.stream;
});
