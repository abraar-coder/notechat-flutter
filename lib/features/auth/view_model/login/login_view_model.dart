import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_chat/core/services/firebase_auth_service.dart';
import 'package:note_chat/core/validators/auth_validators.dart';
import 'package:note_chat/features/auth/view_model/login/login_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final FirebaseAuthService _authService;

  LoginViewModel(this._authService) : super(LoginState());

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void onLoginEmailChanged(String email) {
    state = state.copyWith(email: email);
  }

  void onLoginPasswordChanged(String password) {
    state = state.copyWith(password: password);
  }

  Future<bool> login() async {
    final emailError = AuthValidators.validateEmail(state.email);
    final passwordError = AuthValidators.validatePassword(state.password);

    final hasErrors = emailError != null || passwordError != null;

    if (hasErrors) {
      state = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      generalError: null,
      emailError: null,
      passwordError: null,
    );

    try {
      await _authService.loginWithEmail(
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