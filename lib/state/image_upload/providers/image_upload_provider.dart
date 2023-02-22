import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../typedefs/is_loading.dart';
import 'notifier/image_upload_notifier.dart';
final imageUploadProvider = StateNotifierProvider<ImageUploadNotifier,IsLoading>((ref)=>ImageUploadNotifier());