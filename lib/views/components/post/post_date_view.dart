import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instagram_clone_with_firebase/state/posts/models/post.dart';
import 'package:intl/intl.dart';

class PostDateView extends StatelessWidget {
  const PostDateView({required this.dateTime, super.key});
  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d MMM,yyyy, hh:mm a ');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(formatter.format(dateTime)),
    );
  }
}
