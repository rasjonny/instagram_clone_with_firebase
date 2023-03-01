import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/extensions/get_collection_name_from_enum.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';

import '../models/post.dart';

class DeletePostStateNotifier extends StateNotifier<IsLoading> {
  DeletePostStateNotifier() : super(false);
  set isLoading(bool value) => state = value;

  Future<bool> deletePost({required Post post}) async {
    isLoading = true;

    try {
      FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(FirebaseCollectionNames.thumbnails)
          .child(post.thumbnailStorageId)
          .delete();
      FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.getCollectionName())
          .child(post.originalFileStorageId)
          .delete();
      await _deleteAlldocumments(
          postId: post.postId, inCollection: FirebaseCollectionNames.comments);
      await _deleteAlldocumments(
          postId: post.postId, inCollection: FirebaseCollectionNames.likes);

      final query = await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.posts)
          .where(FieldPath.documentId, isEqualTo: post.postId)
          .limit(1)
          .get();

      for (final doc in query.docs) {
        doc.reference.delete();
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteAlldocumments({
    required PostId postId,
    required String inCollection,
  }) async {
    FirebaseFirestore.instance.runTransaction(
        maxAttempts: 3,
        timeout: const Duration(seconds: 20), (transaction) async {
      final query = await FirebaseFirestore.instance
          .collection(inCollection)
          .where(FirebaseFieldNames.postId, isEqualTo: postId)
          .get();
      for (final doc in query.docs) {
        transaction.delete(doc.reference);
      }
    });
  }
}
