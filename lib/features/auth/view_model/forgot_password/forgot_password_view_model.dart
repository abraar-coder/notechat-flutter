import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_chat/core/services/firebase_auth_service.dart';
import 'package:note_chat/core/validators/auth_validators.dart';
import 'package:note_chat/features/auth/view_model/forgot_password/forgot_password_state.dart';

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  final FirebaseAuthService _authService;
  ForgotPasswordViewModel(this._authService) : super(ForgotPasswordState());

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  Future<bool> forgotPassword() async {
    final emailError = AuthValidators.validateEmail(state.email);

    if (emailError != null) {
      state = state.copyWith(emailError: emailError);
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authService.sendPasswordResetEmail(state.email);
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
