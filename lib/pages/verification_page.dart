import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../configuration/theme.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<String> code = List.filled(6, '');

  void _onKeyTap(String value) {
    setState(() {
      for (int i = 0; i < code.length; i++) {
        if (code[i].isEmpty) {
          code[i] = value;
          break;
        }
      }
    });

    // Redirection ou action automatique dès que le code à 6 chiffres est complet
    if (!code.contains('')) {
      _verifyCode();
    }
  }

  void _onBackspace() {
    setState(() {
      for (int i = code.length - 1; i >= 0; i--) {
        if (code[i].isNotEmpty) {
          code[i] = '';
          break;
        }
      }
    });
  }

  void _verifyCode() {
    final fullCode = code.join();
    debugPrint('Code saisi : $fullCode');
    // Logique de vérification API ou navigation après validation
    // context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppTheme.textPrimary,
              size: 18,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Vérification',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    // Icone de sécurité alignée avec primaryGreen
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified_user_outlined,
                        size: 36,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Authentification',
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Entrez le code de vérification à 6 chiffres envoyé au numéro •••• 4821',
                      textAlign: TextAlign.center,
                      style: AppTheme.subtitleStyle.copyWith(
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Zones de saisie des chiffres
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) {
                          final isFilled = code[index].isNotEmpty;
                          return Container(
                            width: 46,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isFilled
                                    ? AppTheme.primaryGreen
                                    : Colors.grey.shade300,
                                width: isFilled ? 2.0 : 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              code[index],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextButton(
                      onPressed: () {
                        // Action de renvoi du code
                      },
                      child: Text(
                        'Renvoyer le code dans 0:29',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Pavé numérique sur mesure
            Container(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 32,
                right: 32,
                top: 12,
              ),
              child: Column(
                children: [
                  _buildNumRow(['1', '2', '3']),
                  _buildNumRow(['4', '5', '6']),
                  _buildNumRow(['7', '8', '9']),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 64, height: 54),
                      _buildNumButton('0'),
                      SizedBox(
                        width: 64,
                        height: 54,
                        child: IconButton(
                          icon: const Icon(
                            Icons.backspace_outlined,
                            size: 22,
                            color: AppTheme.textPrimary,
                          ),
                          onPressed: _onBackspace,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumRow(List<String> values) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: values.map((val) => _buildNumButton(val)).toList(),
      ),
    );
  }

  Widget _buildNumButton(String val) {
    return SizedBox(
      width: 64,
      height: 54,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => _onKeyTap(val),
        child: Text(
          val,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
