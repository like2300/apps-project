import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../configuration/theme.dart';

class CrossLabelField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CrossLabelField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: AppTheme.inputDecoration(
        labelText: label,
        hintText: '',
      ),
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
          onPressed: () => context.pop(),
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                const Text(
                  'Mot de passe oublié ?',
                  style: AppTheme.titleStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  'Renseignez vos informations pour recevoir votre code ou lien de réinitialisation.',
                  style: AppTheme.subtitleStyle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 32),

                const CrossLabelField(
                  label: 'N° assuré(e)',
                  hint: '',
                ),
                const SizedBox(height: 18),

                const CrossLabelField(
                  label: 'N° téléphone',
                  hint: '',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 32),

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
        ),
      ),
    );
  }
}