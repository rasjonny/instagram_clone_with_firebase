import 'dart:collection' show MapView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/image_upload/models/file_types.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone_with_firebase/state/post_setting/models/post_setting.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post_key.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

@immutable
class PostPayLoad extends MapView<String, dynamic> {
  PostPayLoad(
      {required UserId userId,
      required String message,
      required String thumbnailUrl,
      required String fileUrl,
      required FileType fileType,
      required String fileName,
      required double aspectRatio,
      required String thumbnailStorageId,
      required String originalFileStorageId,
      required Map<PostSetting, bool> postSettings})
      : super({
        PostKey.userId:userId,
PostKey.message:message,

PostKey.createdAt:FieldValue.serverTimestamp(),
PostKey.thumbnailUrl:thumbnailUrl,
PostKey.fileUrl:fileUrl,
PostKey.fileType:fileType.name, 
PostKey.fileName:fileName,
PostKey.aspectRatio:aspectRatio,
        PostKey.thumbnailStorageId:thumbnailStorageId,
        PostKey.originalFileStorageId:originalFileStorageId,
        PostKey.postSetting:{for (final postSetting in postSettings.entries)
        postSetting.key.storageKey:postSetting.value}
      });
}
