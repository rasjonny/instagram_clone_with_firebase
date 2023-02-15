import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_with_firebase/state/auth/models/auth_result.dart';
import 'package:instagram_clone_with_firebase/state/auth/models/auth_state.dart';
import 'package:instagram_clone_with_firebase/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone_with_firebase/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfo = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          isLoading: false,
          userId: _authenticator.userId,
          result: AuthResult.success);
    }
  }
  Future<void> logOut() async {
    state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<AuthResult> loginWithGoogle() async {
    state.copiedWithIsLoading(true);
    final result = await _authenticator.logInWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      isLoading: false,
      userId: userId,
      result: result,
    );
    return state.result ?? AuthResult.failure;
  }

  Future<void> saveUserInfo({required UserId userId}) async {
    await _userInfo.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.userEmail);
  }
}
