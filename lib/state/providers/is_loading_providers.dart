import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/auth_state_providers.dart';

import '../image_upload/providers/image_upload_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final imageUpload = ref.watch(imageUploadProvider);
  final isLoading = authState.isLoading;
  return isLoading||imageUpload;
});
