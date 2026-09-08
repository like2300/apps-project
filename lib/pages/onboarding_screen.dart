import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../configuration/theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Section Logo et Marque
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shield_rounded,
                          size: 40,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'MY CAMU',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Titre principal
                const Text(
                  'Accédez à vos services en toute simplicité',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                // Sous-titre
                Text(
                  'Gérez vos assurances, vos remboursements et vos démarches administratives en quelques clics.',
                  textAlign: TextAlign.center,
                  style: AppTheme.subtitleStyle.copyWith(
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 48),

                // Bouton Se connecter
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.go('/login'),
                    style: AppTheme.primaryButtonStyle,
                    child: const Text(
                      'Se connecter',
                      style: AppTheme.buttonTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Bouton Créer un compte
                SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () => context.go('/register'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryGreen,
                      side: const BorderSide(
                        color: AppTheme.primaryGreen,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Créer un compte',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
