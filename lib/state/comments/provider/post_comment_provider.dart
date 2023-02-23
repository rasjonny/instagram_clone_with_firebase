import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/comments/extension/sorting_by_request.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/comments_model.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/request_post_comment.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';

final postCommentProvider = StreamProvider.family
    .autoDispose<Iterable<CommentsModel>, RequestPostAndComment>(
        (ref, RequestPostAndComment request) {
  final controller = StreamController<Iterable<CommentsModel>>();
  final subs = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.comments)
      .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
      .snapshots()
      .listen((snapshot) {
    final document = snapshot.docs;
    final limitedDocument =
        request.limit != null ? document.take(request.limit!) : document;
    final comments =
        limitedDocument.where((doc) => !doc.metadata.hasPendingWrites).map(
              (document) =>
                  CommentsModel(json: document.data(), id: document.id),
            );
    final sortedComments = comments.applySortingFrom(request);
    controller.sink.add(sortedComments);
  });
  ref.onDispose(() {
    controller.close();
    subs.cancel();
  });
  return controller.stream;
});
