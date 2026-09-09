import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';
import 'theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/images/background.jpg',
      'title': 'Bienvenue sur votre Espace',
      'subtitle':
          'Accédez à l\'ensemble de vos démarches et à la gestion de vos services d\'assurance en toute simplicité.',
    },
    {
      'image': 'assets/images/img/fond.jpeg',
      'title': 'Suivi & Inscription Simplifiée',
      'subtitle':
          'Consultez vos dossiers, effectuez vos mises à jour et restez informé en temps réel depuis votre mobile.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      context.goNamed(AppRoutes.start);
    }
  }

  void _onBackPressed() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentIndex == _onboardingData.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. PageView pour le fond d'écran et les textes
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              final item = _onboardingData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              index == 0
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFF0F172A),
                              AppTheme.primaryGreen.withValues(alpha: 0.35),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Dégradé sombre en bas pour garantir la lisibilité du texte
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.4),
                          Colors.black.withValues(alpha: 0.85),
                          Colors.black,
                        ],
                        stops: const [0.3, 0.6, 0.85, 1.0],
                      ),
                    ),
                  ),

                  // Titres et Sous-titres
                  Positioned(
                    bottom: 140,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['subtitle']!,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // 2. Pied de page (Indicateurs à gauche + Boutons alignés à droite)
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Indicateurs (points)
                Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 6),
                      width: _currentIndex == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                // Groupe de boutons à droite
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Bouton Retour


                    // Bouton Suivant / GET STARTED
                    ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.textPrimary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isLastPage ? 'COMMENCER' : 'Suivant',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            isLastPage
                                ? Icons.rocket_launch_rounded
                                : Icons.arrow_forward_ios_rounded,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
