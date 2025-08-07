import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_chat/core/constants/app_constants.dart';
import 'package:note_chat/core/theme/app_theme.dart';
import 'package:note_chat/router/app_router.dart';

class NoteChatApp extends ConsumerWidget {
  const NoteChatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    final appRoutes = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      themeMode: appTheme.themeMode,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      routerConfig: appRoutes,
    );
  }
}