import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_chat/core/constants/app_constants.dart';
import 'package:note_chat/core/theme/app_spacing.dart';
import 'package:note_chat/core/theme/app_text_styles.dart';
import 'package:note_chat/router/app_route_path.dart';
import 'package:note_chat/shared/widgets/shimmer_icon.dart';
import 'package:note_chat/shared/widgets/shimmer_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        context.go(AppRoutePaths.login);
      } // ✅ Navigate with GoRouter
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Safe way to trigger post-build logic
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToLogin(context);
    });

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerIcon(
              icon: Icons.note_alt_outlined,
              color: colorScheme.primary,
            ),
            AppSpacing.h24,
            ShimmerText(
              text: AppConstants.welcome,
              style: AppTextStyles.splashTitle,
              color: colorScheme.primary,
            ),
            AppSpacing.h8,
            ShimmerText(
              text: AppConstants.onePlace,
              style: AppTextStyles.bodyLarge,
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}