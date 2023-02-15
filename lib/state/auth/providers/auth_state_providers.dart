import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_with_firebase/state/auth/models/auth_state.dart';
import 'package:instagram_clone_with_firebase/state/auth/notifier/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier,AuthState>((ref) => AuthStateNotifier());
