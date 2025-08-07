import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_chat/core/constants/app_constants.dart';
import 'package:note_chat/core/providers/providers.dart';
import 'package:note_chat/core/theme/app_spacing.dart';
import 'package:note_chat/features/auth/widgets/auth_button.dart';
import 'package:note_chat/features/auth/widgets/auth_layout.dart';
import 'package:note_chat/features/auth/widgets/auth_textfield.dart';
import 'package:note_chat/router/app_route_path.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginNotifier = ref.read(loginViewModelProvider.notifier);

    return AuthLayout(
      title: AppConstants.welcomeBack,
      subtitle: AppConstants.loginAccount,
      formFields: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            hintText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
            onChanged: loginNotifier.onLoginEmailChanged,
            errorText: loginState.emailError,
          ),
          AppSpacing.h16,
          AuthTextField(
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            obscureText: !loginState.isPasswordVisible, // 👈 based on state
            onChanged: loginNotifier.onLoginPasswordChanged,
            errorText: loginState.passwordError,
            suffixIcon: IconButton(
              icon: Icon(
                loginState.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: loginNotifier.togglePasswordVisibility,
            ),
          ),
          AppSpacing.h8,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.go(AppRoutePaths.forgotPassword);
              },
              child: const Text("Forgot Password?"),
            ),
          ),
        ],
      ),
      button: AuthButton(
        label: 'Login',
        isLoading: loginState.isLoading,
        onPressed: () async {
          final success = await loginNotifier.login();
          if (success && context.mounted) {
            context.go(AppRoutePaths.home); // ✅ navigation in UI
          }
        },
      ),
      bottom: Column(
        children: [
          AppSpacing.h16,
          const _OrDivider(),
          AppSpacing.h16,
          _ThirdPartyLoginButtons(),
          AppSpacing.h24,
          _RegisterText(),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _ThirdPartyLoginButtons extends ConsumerWidget {
  const _ThirdPartyLoginButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anonState = ref.watch(anonymousSignInViewModelProvider);
    final anonNotifier = ref.read(anonymousSignInViewModelProvider.notifier);

    return Column(
      children: [
        AuthButton(
          icon: Icons.person,
          label: 'Sign in Anonymously',
          isLoading: anonState.isLoading,
          onPressed: () async {
            final success = await anonNotifier.signInAnonymously();
            if (success && context.mounted) {
              context.go(AppRoutePaths.home);
            }
          },
        ),
        AppSpacing.h12,
        AuthButton(
          icon: Icons.g_mobiledata,
          label: 'Sign in with Google',
          onPressed: () {
            // TODO: Implement Google Sign-In
          },
        ),
      ],
    );
  }
}

class _RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          TextSpan(
            text: "Register",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.go(AppRoutePaths.register);
              },
          ),
        ],
      ),
    );
  }
}
