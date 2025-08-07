import 'package:flutter/material.dart';
import 'package:note_chat/core/theme/app_spacing.dart';
import 'package:note_chat/core/theme/app_text_styles.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget formFields;
  final Widget button;
  final Widget? bottom;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.formFields,
    required this.button,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;
          final content = Padding(
            padding: AppSpacing.screen,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    AppSpacing.h8,
                    Text(
                      subtitle,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    AppSpacing.h24,
                    formFields,
                    AppSpacing.h24,
                    button,
                    if (bottom != null) ...[
                      AppSpacing.h16,
                      Center(child: bottom!),
                    ],
                  ],
                ),
              ),
            ),
          );

          return isWide
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                      ),
                    ),
                    Expanded(child: content),
                  ],
                )
              : content;
        },
      ),
    );
  }
}