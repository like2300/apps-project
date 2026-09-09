import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'configuration/onboarding_screen.dart';
import 'pages/forgot_password_page.dart';
import 'pages/start_page.dart';
import 'pages/verification_page.dart';

abstract class AppRoutes {
  static const String start = 'start';
  static const String onboarding = 'onboarding';
  static const String forgotPassword = 'forgot-password';
  static const String verification = 'verification';
}

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.start,
      builder: (context, state) => const StartPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/verification',
      name: AppRoutes.verification,
      builder: (context, state) => const VerificationPage(),
    ),
  ],
);
