import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instagram_clone_with_firebase/views/components/animations/empty_content_animation_view.dart';

class EmptyContentWithTextAnimationView extends StatelessWidget {
  const EmptyContentWithTextAnimationView({
    required this.text,
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white54),
            ),
          ),
          const EmptyContentAnimationView(),
        ],
      ),
    );
  }
}
