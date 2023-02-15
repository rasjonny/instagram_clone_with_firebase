import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/constants/firebase_fields_name.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  final UserId userId;
  final String? displayName;
  final String? email;
  UserInfoPayload({
    required this.userId,
    required this.displayName,
    required this.email,
  }) : super({
          FirebaseFieldNames.userId: userId,
          FirebaseFieldNames.displayName: displayName??'',
          FirebaseFieldNames.email: email??''
        });
}
