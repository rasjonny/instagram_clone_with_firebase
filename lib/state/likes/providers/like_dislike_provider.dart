import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/likes/models/like.dart';
import 'package:instagram_clone_with_firebase/state/likes/models/like_dislike_model.dart';

final likeDislikePostProvider = FutureProvider.family
    .autoDispose<bool, LikeDisLikeRequest>(
        (ref, LikeDisLikeRequest request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.likes)
      .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
      .where(FirebaseFieldNames.userId, isEqualTo: request.userId)
      .get();
  final hasLiked = await query.then((value) => value.docs.isNotEmpty);

  if (hasLiked) {
    try {
      await query.then((snapshot) async {
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  } else {
    try {
      final like = Like(
        postId: request.postId,
        likedby: request.userId,
        dateTime: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.likes)
          .add(like);
      return true;
    } catch (e) {
      return false;
    }
  }
});
