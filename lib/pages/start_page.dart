import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../configuration/theme.dart';
import 'auth_sheets.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageSectionHeight = screenHeight * 0.55;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // --- Section Image + Conteneur avec Arche Inversée ---
            SizedBox(
              height: imageSectionHeight,
              width: double.infinity,
              child: Stack(
                children: [
                  // Image de fond avec dégradé par défaut
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Dégradé par défaut si l'image n'est pas disponible
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppTheme.primaryGreen.withOpacity(0.2),
                                AppTheme.backgroundColor,
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // 2. Overlay Dégradé Vert CAMU
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppTheme.primaryGreen.withOpacity(0.85),
                            Colors.black.withOpacity(0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 3. Masque Blanc avec l'arche concave en bas de l'image
                  Positioned(
                    bottom: -0.7,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: TopArcClipper(),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Section Texte et Boutons ---
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CAMU',
                    style: AppTheme.titleStyle.copyWith(
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Votre santé, notre priorité.Accédez à vos services de couverture santé universelle.',
                    textAlign: TextAlign.center,
                    style: AppTheme.subtitleStyle.copyWith(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Bouton Se Connecter
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const LoginSheet(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      minimumSize: const Size(double.infinity, 54),
                    ),
                    child: const Text(
                      'Se connecter',
                      style: AppTheme.buttonTextStyle,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Bouton S'inscrire
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const RegisterSheet(),
                      );
                    },
                    style: AppTheme.outlinedButtonStyle,
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper pour créer la courbe inversée/concave (arche)
class TopArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Commencer en haut à gauche
    path.moveTo(0, 0);

    // Dessiner une courbe de Bézier pour créer une arche concave
    final midHeight =
        size.height * 0.5; // Étendre légèrement pour éviter les artefacts
    path.quadraticBezierTo(
      size.width / 2, // Point de contrôle central en X
      midHeight, // Creux au centre
      size.width, // Arrivée en haut à droite
      0,
    );

    // Fermer le chemin
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
