import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/image_upload/models/thumbnail_request.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';

import '../../state/image_upload/providers/thumbnail_provider.dart';

class ThumbnailView extends ConsumerWidget {
  const ThumbnailView({required this.thumbnailRequest, super.key});
  final ThumbnailRequest thumbnailRequest;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageWithAspectRatio = ref.watch(thumbnailProvider(thumbnailRequest));
    return imageWithAspectRatio.when(
        data: (data) => AspectRatio(
              aspectRatio: data.aspectRatio,
              child: data.image,
            ),
        error: (e, s) {
          return const ErrorAnimationView();
        },
        loading: () => const LoadingAnimationView());
  }
}
