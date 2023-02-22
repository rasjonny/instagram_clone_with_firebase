import 'dart:io' show File;
import 'package:image_picker/image_picker.dart' show XFile;

extension ToFile on Future<XFile?>{
  Future<File?> toFile()=>then((xfile) => xfile?.path).then((filePath) => filePath!=null?File(filePath):null,);
}