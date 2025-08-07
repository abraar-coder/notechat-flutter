import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_chat/core/providers/providers.dart';
import 'package:note_chat/features/auth/widgets/auth_button.dart';
import 'package:note_chat/features/auth/widgets/auth_textfield.dart';
import 'package:note_chat/router/app_route_path.dart';
import 'package:note_chat/features/auth/widgets/auth_layout.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailState = ref.watch(forgotPasswordViewModelProvider);
    final emailNotifier = ref.read(forgotPasswordViewModelProvider.notifier);

    return AuthLayout(
      title: "Forgot Password?",
      subtitle:
          "Enter the email linked to your account to receive a reset link.",
      formFields: Column(
        children: [
          AuthTextField(
            hintText: "Email Address",
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            onChanged: emailNotifier.onEmailChanged,
            errorText: emailState.emailError,
          ),
        ],
      ),
      button: AuthButton(
        label: "Send Reset Link",
        icon: Icons.send,
        onPressed: () async {
          final success = await emailNotifier.forgotPassword();
          if (success && context.mounted) {
            context.go(AppRoutePaths.login);
          }
        },
      ),
      bottom: TextButton(
        onPressed: () => context.go(AppRoutePaths.login),
        child: const Text("Back to Login"),
      ),
    );
  }
}