import 'dart:convert';


import 'package:firstparc/Models/mecanicien.dart';
import 'package:http/http.dart' as http;


class MecanicienApi {
  Future<List<String>> fetchMecaniciens() async {
    try {
      final uri = Uri.parse('https://10.0.2.2:7116/api/Mecaniciens');
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
        List<Mecanicien> mecanicienList = 
        jsonData.map((json) => Mecanicien.fromJson(json)).toList();
        List<String> mecanicienNames = mecanicienList
        .map((mecanicien) => '${mecanicien.prenomM} ${mecanicien.nomM}' )
        .toList();
        return mecanicienNames;
      } else {
        print('Erreur lors de la récupération des véhicules : ${response.statusCode}');
        print('Réponse du serveur : ${response.body}');
        return [];
      }
    } catch(e) {
      print('Erreur lors de la récupération : $e');
      return [];
    }
  }
}