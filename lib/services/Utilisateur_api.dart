import 'dart:convert';
import 'package:firstparc/Models/Utilisateur.dart';
import 'package:http/http.dart' as http;


class UtilisateurApi {
 static Future<bool> authenticate(Utilisateur user) async {
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
      if (response.statusCode == 200){
        
        return true;
      } else {
        
        return false;
      }
    } catch(e) {
      print('Erreur lors de l\'authentification : $e');
      return false;
    }
  }
}