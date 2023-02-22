import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/constants/constants.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/exception/could_not_build_thumbnail_request.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/extensions/get_collection_name_from_enum.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/extensions/get_image_data_aspect_ratio.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/models/file_types.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_with_firebase/state/post_setting/models/post_setting.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post_payload.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8list;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailRequest();
        }
        final thumb =
            img.copyResize(fileAsImage, width: Constants.imageThumbnailWidth);
        final thumbnailData = img.encodeJpg(thumb);
        thumbnailUint8list = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          maxHeight: Constants.videoThumbnailMaxHeight,
          imageFormat: ImageFormat.JPEG,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailRequest();
        }
        thumbnailUint8list = thumb;
        break;
    }

    final thumbnailAspectRatio = await thumbnailUint8list.getAspectRatio();
    final fileName = const Uuid().v4();
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionNames.thumbnails)
        .child(fileName);
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.getCollectionName())
        .child(fileName);

    try {
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8list);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;
      final postPayLoad = PostPayLoad(
          userId: userId,
          message: message,
          thumbnailUrl: await thumbnailRef.getDownloadURL(),
          fileUrl: await originalFileRef.getDownloadURL(),
          fileType: fileType,
          fileName: fileName,
          aspectRatio: thumbnailAspectRatio,
          thumbnailStorageId: thumbnailStorageId,
          originalFileStorageId: originalFileStorageId,
          postSettings: postSettings);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.posts)
          .add(postPayLoad);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
