import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../configuration/theme.dart';

// =============================================
// COMPOSANT CONNEXION (Bottom Sheet)
// =============================================
class LoginSheet extends StatefulWidget {
  const LoginSheet({super.key});

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Poignée décorative
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Titre
              Text(
                'Connexion',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 24),

              // Champ N° assuré
              const Text('N° assuré(e)', style: AppTheme.labelStyle),
              const SizedBox(height: 8),
              TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                decoration: AppTheme.inputDecoration(
                  hintText: 'Entrez votre numéro d\'assuré(e)',
                  suffixIcon: Icons.person_outline,
                ),
              ),
              const SizedBox(height: 16),

              // Champ Mot de passe
              const Text('Mot de passe', style: AppTheme.labelStyle),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: AppTheme.inputDecoration(
                  hintText: 'Entrez votre mot de passe',
                ).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.greyLight,
                      size: 20,
                    ),
                    onPressed: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                  ),
                ),
              ),

              // Mot de passe oublié
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/forgot-password');
                  },
                  child: const Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Bouton Connexion
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Logique de connexion ici
                    // Après succès, fermer le bottom sheet
                    Navigator.pop(context);
                  },
                  style: AppTheme.primaryButtonStyle,
                  child: const Text(
                    'Connexion',
                    style: AppTheme.buttonTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Lien vers inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pas encore de compte ? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Fermer ce sheet et ouvrir le sheet d'inscription
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const RegisterSheet(),
                      );
                    },
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================
// COMPOSANT INSCRIPTION (Bottom Sheet)
// =============================================
class RegisterSheet extends StatefulWidget {
  const RegisterSheet({super.key});

  @override
  State<RegisterSheet> createState() => _RegisterSheetState();
}

class _RegisterSheetState extends State<RegisterSheet> {
  final _formKey = GlobalKey<FormState>();

  final _noAssureController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePass1 = true;
  bool _obscurePass2 = true;

  @override
  void dispose() {
    _noAssureController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildModernInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleObscure,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: AppTheme.labelStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
          decoration: AppTheme.inputDecoration(
            hintText: hint,
            suffixIcon: isPassword ? null : icon,
          ).copyWith(
            prefixIcon: Icon(
              icon,
              color: AppTheme.primaryGreen,
              size: 22,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText!
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    onPressed: onToggleObscure,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Poignée décorative
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Titre
              Text(
                'Créer un compte 👋',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Remplissez vos informations pour commencer',
                style: AppTheme.subtitleStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Champs
              _buildModernInputField(
                label: 'N° assuré(e)',
                hint: 'Ex: 1 85 06 78 123 456',
                icon: Icons.badge_outlined,
                controller: _noAssureController,
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez saisir votre numéro d\'assuré'
                    : null,
              ),
              _buildModernInputField(
                label: 'N° téléphone',
                hint: 'Ex: 06 12 34 56 78',
                icon: Icons.phone_android_outlined,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez saisir votre numéro de téléphone'
                    : null,
              ),
              _buildModernInputField(
                label: 'Mot de passe',
                hint: '••••••••••••',
                icon: Icons.lock_outline_rounded,
                isPassword: true,
                obscureText: _obscurePass1,
                controller: _passwordController,
                onToggleObscure: () =>
                    setState(() => _obscurePass1 = !_obscurePass1),
                validator: (value) => value != null && value.length < 6
                    ? 'Le mot de passe doit contenir au moins 6 caractères'
                    : null,
              ),
              _buildModernInputField(
                label: 'Confirmez le mot de passe',
                hint: '••••••••••••',
                icon: Icons.lock_reset_rounded,
                isPassword: true,
                obscureText: _obscurePass2,
                controller: _confirmPasswordController,
                onToggleObscure: () =>
                    setState(() => _obscurePass2 = !_obscurePass2),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Bouton S'inscrire
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      context.go('/verification');
                    }
                  },
                  style: AppTheme.primaryButtonStyle,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('S\'inscrire', style: AppTheme.buttonTextStyle),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Lien vers connexion
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Déjà un compte ? ",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const LoginSheet(),
                      );
                    },
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
