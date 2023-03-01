import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/comments/extension/sorting_by_request.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/comments_model.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/post_with_comment.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/request_post_comment.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';

final specificPostWithCommentProvider =
    StreamProvider.family.autoDispose<PostWithComment, RequestPostAndComment>(
  (ref, RequestPostAndComment request) {
    Post? post;
    Iterable<CommentsModel>? comments;
    final controller = StreamController<PostWithComment>();
    void notify() {
      final localPost = post;
      if (localPost == null) {
        return;
      }
      final outPutComments = (comments ?? []).applySortingFrom(request);

      final result = PostWithComment(comments: outPutComments, post: post!);
      controller.sink.add(result);
    }

    final postSub = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.posts)
        .where(FieldPath.documentId, isEqualTo: request.postId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        post = null;
        comments = null;
        notify();
        return;
      }
      final doc = snapshot.docs.first;
      if (doc.metadata.hasPendingWrites) {
        return;
      }
      post = Post(postId: doc.id, json: doc.data());
      notify();
    });
    final commentQuery = FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.comments)
        .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
        .orderBy(FirebaseFieldNames.createdAt, descending: true);
    final limitedCommentQuery = request.limit != null
        ? commentQuery.limit(request.limit!)
        : commentQuery;

    final commentSub = limitedCommentQuery.snapshots().listen((snapshot) {
      comments = snapshot.docs
          .where((doc) => !doc.metadata.hasPendingWrites)
          .map((e) => CommentsModel(json: e.data(), id: e.id));
      notify();
    });
    ref.onDispose(() {
      postSub.cancel();
      controller.close();
      commentSub.cancel();
    });
    return controller.stream;
  },
);
