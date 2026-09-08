import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import '../configuration/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);

  final _noAssureController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _noAssureFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  bool _obscurePass1 = true;
  bool _obscurePass2 = true;

  @override
  void initState() {
    super.initState();
    // Écouter les changements de page
    _pageController.addListener(() {
      currentPageNotifier.value = _pageController.page?.round() ?? 0;
    });
    // Mise à jour de l'indicateur d'étape selon le champ actif
    _noAssureFocus.addListener(() => _updatePage(0));
    _phoneFocus.addListener(() => _updatePage(1));
    _passwordFocus.addListener(() => _updatePage(2));
    _confirmFocus.addListener(() => _updatePage(3));
  }

  void _updatePage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _noAssureController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _noAssureFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();

    _pageController.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }

  Widget _buildCleanInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required FocusNode focusNode,
    bool isPassword = false,
    bool? obscureText,
    VoidCallback? onToggleObscure,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.labelStyle.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTheme.hintStyle,
            filled: true,
            fillColor: AppTheme.inputFillColor,
            prefixIcon: Icon(
              icon,
              color: AppTheme.greyLight,
              size: 20,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText!
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.greyLight,
                      size: 20,
                    ),
                    onPressed: onToggleObscure,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppTheme.primaryGreen,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppTheme.errorColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppTheme.errorColor,
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.textPrimary,
            size: 22,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // En-tête
              Text(
                'Créer un compte',
                style: AppTheme.titleStyle.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Remplissez vos informations pour commencer',
                style: AppTheme.subtitleStyle.copyWith(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),

              const SizedBox(height: 32),

              // Formulaire
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildCleanInputField(
                      label: 'N° assuré(e)',
                      hint: 'Ex: 1 85 06 78 123 456',
                      icon: Icons.badge_outlined,
                      controller: _noAssureController,
                      focusNode: _noAssureFocus,
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Veuillez saisir votre numéro d\'assuré'
                          : null,
                    ),
                    _buildCleanInputField(
                      label: 'N° téléphone',
                      hint: 'Ex: 06 12 34 56 78',
                      icon: Icons.phone_android_outlined,
                      controller: _phoneController,
                      focusNode: _phoneFocus,
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Veuillez saisir votre numéro de téléphone'
                          : null,
                    ),
                    _buildCleanInputField(
                      label: 'Mot de passe',
                      hint: '••••••••••••',
                      icon: Icons.lock_outline_rounded,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      isPassword: true,
                      obscureText: _obscurePass1,
                      onToggleObscure: () => setState(
                        () => _obscurePass1 = !_obscurePass1,
                      ),
                      validator: (value) => value != null && value.length < 6
                          ? 'Au moins 6 caractères requis'
                          : null,
                    ),
                    _buildCleanInputField(
                      label: 'Confirmez le mot de passe',
                      hint: '••••••••••••',
                      icon: Icons.lock_reset_rounded,
                      controller: _confirmPasswordController,
                      focusNode: _confirmFocus,
                      isPassword: true,
                      obscureText: _obscurePass2,
                      onToggleObscure: () => setState(
                        () => _obscurePass2 = !_obscurePass2,
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    // Bouton Soumettre
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.go('/verification');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'S\'inscrire',
                              style: AppTheme.buttonTextStyle,
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Indicateur de progression épuré
              Center(
                child: CirclePageIndicator(
                  itemCount: 4,
                  currentPageNotifier: currentPageNotifier,
                  size: const Size(6, 6),
                  selectedSize: const Size(18, 6),
                  color: AppTheme.borderColor,
                  selectedColor: AppTheme.primaryGreen,
                  spacing: 6,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
