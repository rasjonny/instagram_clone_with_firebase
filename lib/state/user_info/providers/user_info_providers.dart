import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone_with_firebase/state/user_info/models/user_info_model.dart';

final userInfoProviders = StreamProvider.family
    .autoDispose<UserInfoModel, UserId>((ref, UserId userId) {
  final controller = StreamController<UserInfoModel>();
  ref.onDispose(() {
    controller.close();
  });
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionNames.users)
      .where(FirebaseFieldNames.userId, isEqualTo: userId)
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    final doc = snapshot.docs.first;
    final json = doc.data();
    final userInfoModel = UserInfoModel.fromJson(json, userId: userId);
    controller.add(userInfoModel);
    
  });
  return controller.stream;
});
