import 'dart:convert';

import 'package:firstparc/Models/CkTitres.dart';
import 'package:http/http.dart' as http;


class CkTitresApi {
  Future<List<String>> fetchCkTitres() async {
    try {
      final uri = Uri.parse('https://localhost:44320/api/CkTitres');
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
        List<CkTitres> cktitresList = 
        jsonData.map((json) => CkTitres.fromJson(json)).toList();
        List<String> designation = cktitresList
        .map((cktitres) => cktitres.designation)
        .toList();
        return designation;
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