import 'dart:convert';
import 'package:firstparc/Models/chauffeur.dart';
import 'package:http/http.dart' as http;


class ChauffeurApi {
  Future<List<String>> fetchChauffeurs() async {
    try {
      final uri = Uri.parse('https://10.0.2.2:7116/api/Chauffeurs');
      final response = await http.get(
        uri,
        headers: {
          "access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
      );

      if (response.statusCode == 200){
        final List<dynamic> jsonData = jsonDecode(response.body);
        List<Chauffeur> chauffeurList = 
        jsonData.map((json) => Chauffeur.fromJson(json)).toList();
        List<String> chauffeurNames = chauffeurList
        .map((chauffeur) => '${chauffeur.prenomC} ${chauffeur.nomC}' )
        .toList();
        return chauffeurNames;
      } else {
        print('Erreur lors de la récupération des chauffeurs : ${response.statusCode}');
        print('Réponse du serveur : ${response.body}');
        return [];
      }
    } catch(e) {
      print('Erreur lors de la récupération : $e');
      return [];
    }
  }
}