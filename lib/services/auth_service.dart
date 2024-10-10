import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'http://10.1.19.2:3000';
  Future<bool> signIn(String emailCompte, String mdpCompte) async {
    print('Tentative de connexion avec: $emailCompte');
    final response = await http.post(
      Uri.parse('$baseUrl/connexion'),
      body: json.encode({'emailCompte': emailCompte, 'mdpCompte': mdpCompte}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Réponse du serveur: ${response.body}');
      print('Statut de la réponse: ${response.statusCode}');
      return true;
    }

    return false;
  }

// inscription
  Future<bool> signUp(String nom, String emailCompte, String mdpCompte, String telephone, String TypeCompte,
      String villeAgent, String cniAgent, String businessRegistrationNumber) async {
    print('Tentative dinscription avec: $emailCompte');

    final Map<String, dynamic> body = {
      'nom': nom,
      'emailCompte': emailCompte,
      'mdpCompte': mdpCompte,
      'telephone': telephone,
      'TypeCompte': TypeCompte,
    };

    if (TypeCompte == 'Professionnel' || TypeCompte == 'Entreprise') {
      body.addAll({
        'villeAgent': villeAgent,
        'businessRegistrationNumber': businessRegistrationNumber,
        'cniAgent': cniAgent,
      });
    }

    final response = await http.post(
      Uri.parse('$baseUrl/inscription'),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print('Réponse du serveur: ${response.body}');
      print('Statut de la réponse: ${response.statusCode}');
      return true;
    }

    return false;
  }

  Future<bool> googleSignIn(String idToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/connexion/google-signin'),
      body: json.encode({'idToken': idToken}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }

  Future<bool> signOut() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/deconnexion'),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
      return false;
    }
  }
}
