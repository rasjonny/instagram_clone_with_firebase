import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/comment_payload.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

class CommentNotifier extends StateNotifier<IsLoading> {
  CommentNotifier() : super(false);
  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required PostId postId,
    required UserId userId,
    required String comment,
  }) async {
    try {
      final payLoad =
          CommentPayLoad(comment: comment, userId: userId, postId: postId);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.comments)
          .add(payLoad);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
