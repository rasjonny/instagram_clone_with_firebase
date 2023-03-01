import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/comments_model.dart';
import 'package:instagram_clone_with_firebase/views/components/comment/compact_comment_tile.dart';

class CompactColumnComment extends StatelessWidget {
  const CompactColumnComment({required this.comments, super.key});
  final Iterable<CommentsModel> comments;
  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: comments.map((comment) =>CompactCommentTile(comment: comment,) ).toList(),),
    );
  }
}
