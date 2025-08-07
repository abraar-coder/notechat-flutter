import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_chat/core/services/firebase_auth_service.dart';
import 'package:note_chat/core/validators/auth_validators.dart';
import 'package:note_chat/features/auth/view_model/register/register_state.dart';

class RegisterViewModel extends StateNotifier<RegisterState> {
  final FirebaseAuthService _authService;

  RegisterViewModel(this._authService) : super(RegisterState());

  void onEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
  }

  Future<bool> register() async {
    final emailError = AuthValidators.validateEmail(state.email);
    final passwordError = AuthValidators.validatePassword(state.password);
    final confirmPasswordError = AuthValidators.validateConfirmPassword(
      state.password,
      state.confirmPassword,
    );

    final hasErrors =
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null;

    if (hasErrors) {
      state = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      generalError: null,
      emailError: null,
      passwordError: null,
      confirmPasswordError: null,
    );

    try {
      await _authService.registerWithEmail(
        email: state.email.trim(),
        password: state.password.trim(),
      );
      return true;
    } catch (e) {
      state = state.copyWith(generalError: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
