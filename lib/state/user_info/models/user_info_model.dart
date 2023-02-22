import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String? email;

  UserInfoModel({
    required this.userId,
    required this.displayName,
    required this.email,
  }) : super({
          FirebaseFieldNames.userId: userId,
          FirebaseFieldNames.displayName: displayName,
          FirebaseFieldNames.email: email,
        });
  UserInfoModel.fromJson(Map<String, dynamic> json, {required UserId userId})
      : this(
          userId: userId,
          displayName: json[FirebaseFieldNames.displayName] ?? '',
          email: json[FirebaseFieldNames.email],
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll([runtimeType, email, displayName, userId]);
}
