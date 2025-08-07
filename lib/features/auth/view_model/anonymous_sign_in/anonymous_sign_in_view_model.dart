import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_chat/core/services/firebase_auth_service.dart';
import 'package:note_chat/features/auth/view_model/anonymous_sign_in/anonymous_sign_in_state.dart';

class AnonymousSignInViewModel extends StateNotifier<AnonymousSignInState> {
  final FirebaseAuthService _authService;

  AnonymousSignInViewModel(this._authService) : super(AnonymousSignInState());

  Future<bool> signInAnonymously() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authService.signInAnonymously();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
