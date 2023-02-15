import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone_with_firebase/state/auth/models/auth_result.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final UserId? userId;
  final bool isLoading;

  const AuthState({
    required this.isLoading,
    required this.userId,
    required this.result,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;
  AuthState copiedWithIsLoading(bool isLoading) =>
      AuthState(isLoading: isLoading, userId: userId, result: result);

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      result == other.result &&
          userId == other.userId &&
          isLoading == other.isLoading;

  @override
  int get hashCode => Object.hash(result, userId, isLoading);

  @override
  String toString() =>
      'AuhtState(authState:$result, userId:$userId, isLoading:$isLoading)';
}
