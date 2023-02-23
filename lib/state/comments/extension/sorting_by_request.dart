import 'package:instagram_clone_with_firebase/enums/date_sorting.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/comments_model.dart';
import 'package:instagram_clone_with_firebase/state/comments/models/request_post_comment.dart';

extension SortingByRequest on Iterable<CommentsModel> {
  Iterable<CommentsModel> applySortingFrom(
      RequestPostAndComment requestPostAndComment) {
    if (requestPostAndComment.sortByCreatedAt) {
      final sortedComment = toList()
        ..sort(
          ((a, b) {
            switch (requestPostAndComment.dateSorting) {
              case DateSorting.newestOnTop:
                return a.createdAt.compareTo(b.createdAt);

              case DateSorting.oldestOnTop:
                return b.createdAt.compareTo(a.createdAt);
            }
          }),
        );
      return sortedComment;
    } else {
      return this;
    }
  }
}
