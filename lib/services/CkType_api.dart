import 'dart:convert';

import 'package:firstparc/Models/CkTypesCks.dart';
import 'package:http/http.dart' as http;


class CkTypeApi {
  Future<List<String>> fetchCkType() async {
    try {
      final uri = Uri.parse('https://localhost:44320/api/CkTypeCks');
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
        List<CkTypeCks> cktypeList = 
        jsonData.map((json) => CkTypeCks.fromJson(json)).toList();
        List<String> designation = cktypeList
        .map((cktype) => cktype.designation)
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