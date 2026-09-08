import 'package:flutter/material.dart';
import '../configuration/theme.dart';

class CrossLabelField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CrossLabelField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.labelStyle),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: AppTheme.inputDecoration(
            hintText: hint,
            suffixIcon: icon,
          ),
        ),
      ],
    );
  }
}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Réinitialisation',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Titre et Description
            Text(
              'Mot de passe oublié ?',
              style: AppTheme.titleStyle,
            ),
            const SizedBox(height: 6),
            Text(
              'Renseignez vos informations pour recevoir votre code ou lien de réinitialisation.',
              style: AppTheme.subtitleStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 32),

            // Formulaire
            const CrossLabelField(
              label: 'N° assuré(e)',
              hint: 'Entrez votre numéro d\'assuré(e)',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),

            const CrossLabelField(
              label: 'N° téléphone',
              hint: 'Entrez votre numéro de téléphone',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 32),

            // Bouton de validation
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Logique d'envoi du code / lien
                },
                style: AppTheme.primaryButtonStyle,
                child: const Text(
                  'Envoyer',
                  style: AppTheme.buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

