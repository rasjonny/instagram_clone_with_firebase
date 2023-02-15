import 'package:instagram_clone_with_firebase/state/auth/models/auth_result.dart';
import 'package:instagram_clone_with_firebase/state/auth/providers/auth_state_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final result = ref.watch(authStateProvider);
  return result.result == AuthResult.success;
});
