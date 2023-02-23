import 'package:flutter/foundation.dart';
import 'package:instagram_clone_with_firebase/enums/date_sorting.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/post_id.dart';

@immutable
class RequestPostAndComment {
  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  const RequestPostAndComment({
    required this.postId,
     this.sortByCreatedAt=true,
    this.dateSorting = DateSorting.newestOnTop,
     this.limit,
  });

  @override
  bool operator ==(covariant RequestPostAndComment other) =>
      postId == other.postId &&
      sortByCreatedAt == other.sortByCreatedAt &&
      dateSorting == other.dateSorting &&
      limit == other.limit;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll([
        postId,
        sortByCreatedAt,
        dateSorting,
        limit,
      ]);
}
