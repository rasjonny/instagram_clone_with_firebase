import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/search_term.dart';

final postBySearchTermProvider = StreamProvider.family
    .autoDispose<Iterable<Post>, SearchTerm>((ref, SearchTerm searchTerm) {
  final controller = StreamController<Iterable<Post>>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.posts)
      .orderBy(FirebaseFieldNames.createdAt, descending: true)
      .snapshots()
      .listen((snapShot) {
    final posts = snapShot.docs
        .map(
          (e) => Post(
            postId: e.id,
            json: e.data(),
          ),
        )
        .where(
          (post) => post.message.toLowerCase().contains(
                searchTerm.toLowerCase(),
              ),
        );
    controller.sink.add(posts);
  });
  ref.onDispose(() {
    sub.cancel();

    controller.close();
  });
  return controller.stream;
});
