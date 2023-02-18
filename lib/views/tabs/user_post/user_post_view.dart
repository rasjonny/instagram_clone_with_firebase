import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/posts/providers/user_post_provider.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_grid_view.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';


class UserPostView extends ConsumerWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator( onRefresh: (){ref.refresh(userPostsProvider);
    return Future.delayed(const Duration(seconds:1));},child: posts.when(data: (posts){
      if(posts.isEmpty)
      {
        return const  EmptyContentWithTextAnimationView(text: Strings.youHaveNoPosts);
      }
      else{
        return PostGridView(posts: posts);
      }
    }, error: (e,stacktrace){
      return const ErrorAnimationView();
    }, loading: (){return const LoadingAnimationView();}),);

}
  }

