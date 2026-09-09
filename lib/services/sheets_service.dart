import 'dart:convert';
import 'package:http/http.dart' as http;

// =============================================
// SERVICE AUTHENTIFICATION (utilisé par les sheets)
// =============================================
class SheetsService {
  // TODO: remplacer par l'URL réelle de votre API
  static const String _baseUrl = 'https://api.mycamu.example.com';

  /// Connexion avec numéro d'assuré + mot de passe.
  /// Retourne true si la connexion a réussi.
  static Future<bool> login({
    required String numeroAssure,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'numeroAssure': numeroAssure,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      return false; // Identifiants incorrects
    } else {
      throw Exception('Erreur serveur (${response.statusCode})');
    }
  }

  /// Inscription avec numéro d'assuré + téléphone + mot de passe.
  /// Lève une exception en cas d'échec (message affiché dans le SnackBar).
  static Future<void> register({
    required String numeroAssure,
    required String telephone,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'numeroAssure': numeroAssure,
        'telephone': telephone,
        'password': password,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      String message = 'Erreur lors de l\'inscription';
      try {
        final body = jsonDecode(response.body);
        if (body is Map && body['message'] != null) {
          message = body['message'].toString();
        }
      } catch (_) {}
      throw Exception(message);
    }
  }
}
