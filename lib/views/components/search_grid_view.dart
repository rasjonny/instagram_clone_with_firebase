import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/posts/providers/post_by_search_term_provider.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/search_term.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/data_not_found_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/empty_content_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/error_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_grid_view.dart';
import 'package:instagram_clone_with_firebase/views/components/post/post_silver_grid_view.dart';
import 'package:instagram_clone_with_firebase/views/constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  final SearchTerm searchTerm;
  const SearchGridView({required this.searchTerm, super.key});

  @override
  Widget build(BuildContext context, ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentWithTextAnimationView(
            text: Strings.enterYourSearchTerm),
      );
    } else {
      final searchProvider = ref.watch(
        postBySearchTermProvider(searchTerm),
      );
      return searchProvider.when(
          data: ((posts) {
            if (posts.isEmpty) {
              return const SliverToBoxAdapter(child:  DataNOtFoundAnimationView());
            } else {
              return PostSliverGridview(posts: posts);
            }
          }),
          error: (e, s) =>  const SliverToBoxAdapter(child: ErrorAnimationView()),
          loading: () => const SliverToBoxAdapter(child:  LoadingAnimationView()));
    }
  }
}
