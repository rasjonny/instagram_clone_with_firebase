import 'package:instagram_clone_with_firebase/state/image_upload/models/file_types.dart';

extension GetCollection on FileType {
  String getCollectionName() {
    switch (this) {
      case FileType.image:
        return 'images';

      case FileType.video:
        return 'videos';
        
    }
  }
}
