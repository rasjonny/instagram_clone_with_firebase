import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/user_info/models/user_info_payload.dart';

import '../../posts/typedefs/user_id.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
final userInfo = await FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.users)
        .where(FirebaseFieldNames.userId, isEqualTo: userId)
        .limit(1)
        .get();

    if (userInfo.docs.isNotEmpty) {
      await userInfo.docs.first.reference.update({
        FirebaseFieldNames.displayName: displayName,
        FirebaseFieldNames.email: email ?? ''
      });
      return true;
    }
    final payLoad =
        UserInfoPayload(userId: userId, displayName: displayName, email: email);
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionNames.users)
        .add(payLoad);
    return true;
  
    } catch (e) {
      return false;
    }
    }
}
