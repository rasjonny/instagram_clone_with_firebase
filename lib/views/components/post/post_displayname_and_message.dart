// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:instagram_clone_with_firebase/state/user_info/providers/user_info_providers.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/post/rich_two_part.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  const PostDisplayNameAndMessageView({required this.post, super.key});
  final Post post;
  @override
  Widget build(BuildContext context, ref) {
    final userInfoModel = ref.watch(userInfoProviders(post.userId));
    return userInfoModel.when(
        data: (userInfo) {
          return Padding(padding: const EdgeInsets.all(8),child: RichTwoPart(left: userInfo.displayName,right: post.message,));
        },
        error: ((error, stackTrace) => const ErrorAnimationView()),
        loading: () => const LoadingAnimationView());
  }
}
