import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/views/components/search_grid_view.dart';
import 'package:instagram_clone_with_firebase/views/extension/dismiss_keyboard.dart';

import '../../constants/strings.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = useTextEditingController();
    final searchState = useState('');
    useEffect(() {
      controller.addListener(() {
        searchState.value = controller.text;
      });
      return () {};
    }, [controller]);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  labelText: Strings.enterYourSearchTermHere,
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.clear();
                        disMissKeyBoard();
                      },
                      icon: const Icon(Icons.clear))),
            ),
          ),
        ),
        SearchGridView(
          searchTerm: searchState.value,
        ),
      ],
    );
  }
}
