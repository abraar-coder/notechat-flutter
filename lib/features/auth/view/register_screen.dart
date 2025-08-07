import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_chat/core/providers/providers.dart';
import 'package:note_chat/core/theme/app_spacing.dart';
import 'package:note_chat/features/auth/widgets/auth_button.dart';
import 'package:note_chat/features/auth/widgets/auth_layout.dart';
import 'package:note_chat/features/auth/widgets/auth_textfield.dart';
import 'package:note_chat/router/app_route_path.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerViewModelProvider);
    final registerNotifier = ref.read(registerViewModelProvider.notifier);

    return AuthLayout(
      title: 'Create Account 📝',
      subtitle: 'Register a new account',
      formFields: Column(
        children: [
          AuthTextField(
            hintText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
            onChanged: registerNotifier.onEmailChanged,
            errorText: registerState.emailError,
          ),
          AppSpacing.h16,
          AuthTextField(
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            obscureText: !registerState.isPasswordVisible,
            onChanged: registerNotifier.onPasswordChanged,
            errorText: registerState.passwordError,
            suffixIcon: IconButton(
              icon: Icon(
                registerState.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: registerNotifier.togglePasswordVisibility,
            ),
          ),
          AppSpacing.h16,
          AuthTextField(
            hintText: 'Confirm Password',
            prefixIcon: const Icon(Icons.lock_outline),
            obscureText: !registerState.isConfirmPasswordVisible,
            onChanged: registerNotifier.onConfirmPasswordChanged,
            errorText: registerState.confirmPasswordError,
            suffixIcon: IconButton(
              icon: Icon(
                registerState.isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: registerNotifier.toggleConfirmPasswordVisibility,
            ),
          ),
          if (registerState.generalError != null)
            Text(
              registerState.generalError!,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
      button: AuthButton(
        label: 'Register',
        isLoading: registerState.isLoading,
        onPressed: () async {
          final success = await registerNotifier.register();
          if (success && context.mounted) {
            context.go(AppRoutePaths.login); // ✅ navigation in UI
          }
        },
      ),
      bottom: LoginText(),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge, // base style
        children: [
          TextSpan(
            text: "Already have an account? ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          TextSpan(
            text: "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // 🔁 Navigate to register screen
                context.go(AppRoutePaths.login);
              },
          ),
        ],
      ),
    );
  }
}
