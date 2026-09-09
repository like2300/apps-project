import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../configuration/theme.dart';
import '../router.dart';
import '../services/sheets_service.dart';

// =============================================
// HELPERS : Modal Bottom Sheets Natifs
// =============================================
abstract class AuthSheets {
  static Future<void> showLogin(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const LoginSheet(),
    );
  }

  static Future<void> showRegister(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const RegisterSheet(),
    );
  }
}

// =============================================
// COMPOSANT REUTILISABLE : Champ Saisie
// =============================================
class _AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final String? Function(String?)? validator;

  const _AuthTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimary,
        ),
        decoration: AppTheme.inputDecoration(
          labelText: label,
          hintText: hint,
        ).copyWith(
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.shade600,
                    size: 18,
                  ),
                  onPressed: onToggleObscure,
                )
              : null,
        ),
      ),
    );
  }
}

// =============================================
// COMPOSANT : CONNEXION (avec Animations)
// =============================================
class LoginSheet extends StatefulWidget {
  const LoginSheet({super.key});

  @override
  State<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<LoginSheet>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _switchToRegister() async {
    await _animController.reverse();
    if (!mounted) return;
    Navigator.pop(context);
    AuthSheets.showRegister(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 8,
            bottom: 24 + bottomInset,
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Espace Assuré — Connexion',
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Veuillez vous identifier pour accéder à vos services',
                      style: AppTheme.subtitleStyle.copyWith(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _AuthTextField(
                      label: 'N° d\'assuré',
                      hint: 'Saisissez votre numéro à 13 chiffres',
                      controller: _idController,
                      keyboardType: TextInputType.number,
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Le numéro d\'assuré est requis'
                          : null,
                    ),
                    _AuthTextField(
                      label: 'Mot de passe',
                      hint: 'Saisissez votre mot de passe',
                      controller: _passwordController,
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleObscure: () => setState(
                          () => _obscurePassword = !_obscurePassword),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Le mot de passe est requis'
                          : null,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          final router = GoRouter.of(context);
                          Navigator.pop(context);
                          router.pushNamed(AppRoutes.forgotPassword);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: AppTheme.primaryButtonStyle.copyWith(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Se connecter',
                                  style: AppTheme.buttonTextStyle,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vous n\'avez pas encore de compte ? ',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: _switchToRegister,
                          child: const Text(
                            'Créer un compte',
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.w700,
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
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    setState(() => _isLoading = true);
    try {
      final ok = await SheetsService.login(
        numeroAssure: _idController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            ok
                ? 'Authentification réussie'
                : 'Identifiants non reconnus. Veuillez réessayer.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Erreur de connexion au serveur administratif.'),
        ),
      );
    }
  }
}

// =============================================
// COMPOSANT : INSCRIPTION (avec Animations)
// =============================================
class RegisterSheet extends StatefulWidget {
  const RegisterSheet({super.key});

  @override
  State<RegisterSheet> createState() => _RegisterSheetState();
}

class _RegisterSheetState extends State<RegisterSheet>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _noAssureController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  bool _obscurePass1 = true;
  bool _obscurePass2 = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _noAssureController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _switchToLogin() async {
    await _animController.reverse();
    if (!mounted) return;
    Navigator.pop(context);
    AuthSheets.showLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SlideTransition(
      position: _slideAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 8,
            bottom: 24 + bottomInset,
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Inscription — Nouveau Compte',
                      style: AppTheme.titleStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Renseignez les données d\'identification relatives à votre dossier',
                      style: AppTheme.subtitleStyle.copyWith(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _AuthTextField(
                      label: 'N° d\'assuré',
                      hint: 'Ex: 1 85 06 78 123 456',
                      controller: _noAssureController,
                      keyboardType: TextInputType.number,
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Le numéro d\'assuré est requis'
                          : null,
                    ),
                    _AuthTextField(
                      label: 'Numéro de téléphone portable',
                      hint: 'Ex: 06 12 34 56 78',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Le numéro de téléphone est requis'
                          : null,
                    ),
                    _AuthTextField(
                      label: 'Créer un mot de passe',
                      hint: '6 caractères minimum',
                      controller: _passwordController,
                      isPassword: true,
                      obscureText: _obscurePass1,
                      onToggleObscure: () =>
                          setState(() => _obscurePass1 = !_obscurePass1),
                      validator: (val) => val != null && val.length < 6
                          ? 'Au moins 6 caractères requis'
                          : null,
                    ),
                    _AuthTextField(
                      label: 'Confirmer le mot de passe',
                      hint: 'Répétez le mot de passe',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      obscureText: _obscurePass2,
                      onToggleObscure: () =>
                          setState(() => _obscurePass2 = !_obscurePass2),
                      validator: (val) {
                        if (val != _passwordController.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleRegister,
                        style: AppTheme.primaryButtonStyle.copyWith(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Valider l\'inscription',
                                  style: AppTheme.buttonTextStyle,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vous possédez déjà un compte ? ',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: _switchToLogin,
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.w700,
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
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final router = GoRouter.of(context);

    setState(() => _isLoading = true);
    try {
      await SheetsService.register(
        numeroAssure: _noAssureController.text.trim(),
        telephone: _phoneController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Inscription enregistrée. Code de vérification envoyé.'),
        ),
      );
      router.pushNamed(AppRoutes.verification);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      messenger.showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
