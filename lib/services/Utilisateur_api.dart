import 'dart:convert';
import 'package:firstparc/Models/Utilisateur.dart';
import 'package:http/http.dart' as http;

class UtilisateurApi {
  static Future<Utilisateur?> authenticate(Utilisateur user) async {
    final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs/authenticate');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'loginUser': user.loginUser,
          'motPassUser': user.motPassUser,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return Utilisateur.fromJson(responseData);
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de l\'authentification : $e');
      return null;
    }
  }
//////////////////////////////////    AFFICHER LISTE CHAUFFEUR ///////////////////////////////////////////////////
  static Future<List<Utilisateur>?> fetchChauffeurs() async {
    final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Utilisateur> chauffeurs = responseData
            .map((data) => Utilisateur.fromJson(data))
            .where((user) => user.codeDroit == 3)
            .toList();
             for (var chauffeur in chauffeurs) {
          print('Chauffeur: ${chauffeur.codeUser}, ${chauffeur.loginUser}, ${chauffeur.nomUser}, ${chauffeur.prenomUser}');
             }
        return chauffeurs;
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des chauffeurs : $e');
      return null;
    }
  }
 ////////////////////////////////// UPDATE UTILISATEUR //////////////////////////////////////
static Future<Utilisateur?> updateUtilisateur(Utilisateur utilisateur) async {
  final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs/${utilisateur.codeUser}');

  try {
    final body = jsonEncode(utilisateur.toJson());
    print('Request Body: $body');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 204) {
      if (response.statusCode == 204) {
        return utilisateur;
      }

      final responseData = jsonDecode(response.body);
      return Utilisateur.fromJson(responseData);
    } else {
      return null;
    }
  } catch (e) {
    print('Erreur lors de la mise à jour de l\'utilisateur : $e');
    return null;
  }
}


//////////////////////////////////// Supprimer UTILISATEUR /////////////////////////////////////////
   Future<bool> deleteUtilisateur(int codeUser) async {
  final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs/$codeUser');

  try {
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      return true; // Suppression réussie
    } else {
      print('Erreur lors de la suppression - StatusCode: ${response.statusCode}');
      return false; // Échec de la suppression
    }
  } catch (e) {
    print('Erreur lors de la suppression de l\'utilisateur : $e');
    return false; // Erreur de connexion ou autre
  }
}
//////////////////////////////////    AFFICHER LISTE CHEFS ///////////////////////////////////////////////////
  static Future<List<Utilisateur>?> fetchChefs() async {
    final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Utilisateur> chefs = responseData
            .map((data) => Utilisateur.fromJson(data))
            .where((user) => user.codeDroit == 2)
            .toList();
             for (var chef in chefs) {
          print('Chauffeur: ${chef.codeUser}, ${chef.loginUser}, ${chef.nomUser}, ${chef.prenomUser}');
             }
        return chefs;
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des chauffeurs : $e');
      return null;
    }
  } 
//////////////////////////////////    AFFICHER LISTE Admins ///////////////////////////////////////////////////
  static Future<List<Utilisateur>?> fetchAdmins() async {
    final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Utilisateur> admins = responseData
            .map((data) => Utilisateur.fromJson(data))
            .where((user) => user.codeDroit == 1)
            .toList();
             for (var admin in admins) {
          print('Chauffeur: ${admin.codeUser}, ${admin.loginUser}, ${admin.nomUser}, ${admin.prenomUser}');
             }
        return admins;
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des chauffeurs : $e');
      return null;
    }
  }


//////////////////////////////////    AFFICHER LISTE Mecanicien ///////////////////////////////////////////////////
  static Future<List<Utilisateur>?> fetchMecs() async {
    final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<Utilisateur> mecs = responseData
            .map((data) => Utilisateur.fromJson(data))
            .where((user) => user.codeDroit == 4)
            .toList();
             for (var mec in mecs) {
          print('Chauffeur: ${mec.codeUser}, ${mec.loginUser}, ${mec.nomUser}, ${mec.prenomUser}');
             }
        return mecs;
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des chauffeurs : $e');
      return null;
    }
  }

}
