import 'dart:io' show File;

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/extensions/to_file.dart';

@immutable
class ImagePickerHelper {
  static final imagePicker = ImagePicker();
  static Future<File?> pickImageFromGallery(){
    return imagePicker.pickImage(source: ImageSource.gallery).toFile();
  }
static Future<File?> pickVideoFromGallery(){
    return imagePicker.pickVideo(source: ImageSource.gallery).toFile();
  }
}
