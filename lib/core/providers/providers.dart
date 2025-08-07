import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_chat/core/services/firebase_auth_service.dart';
import 'package:note_chat/features/auth/view_model/anonymous_sign_in/anonymous_sign_in_state.dart';
import 'package:note_chat/features/auth/view_model/anonymous_sign_in/anonymous_sign_in_view_model.dart';
import 'package:note_chat/features/auth/view_model/forgot_password/forgot_password_state.dart';
import 'package:note_chat/features/auth/view_model/forgot_password/forgot_password_view_model.dart';
import 'package:note_chat/features/auth/view_model/login/login_state.dart';
import 'package:note_chat/features/auth/view_model/login/login_view_model.dart';
import 'package:note_chat/features/auth/view_model/register/register_state.dart';
import 'package:note_chat/features/auth/view_model/register/register_view_model.dart';

final firebaseAuthServiceProvider = Provider<FirebaseAuthService>(
  (ref) => FirebaseAuthService(),
);

final registerViewModelProvider =
    StateNotifierProvider.autoDispose<RegisterViewModel, RegisterState>(
      (ref) => RegisterViewModel(ref.read(firebaseAuthServiceProvider)),
    );

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>(
      (ref) => LoginViewModel(ref.read(firebaseAuthServiceProvider)),
    );

final forgotPasswordViewModelProvider =
    StateNotifierProvider.autoDispose<
      ForgotPasswordViewModel,
      ForgotPasswordState
    >((ref) => ForgotPasswordViewModel(ref.read(firebaseAuthServiceProvider)));

final anonymousSignInViewModelProvider =
    StateNotifierProvider<AnonymousSignInViewModel, AnonymousSignInState>(
      (ref) => AnonymousSignInViewModel(ref.watch(firebaseAuthServiceProvider)),
    );

final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges();
});
