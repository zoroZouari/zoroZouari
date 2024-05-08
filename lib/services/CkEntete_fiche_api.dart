import 'dart:convert';

import 'package:firstparc/Models/CkEntete_fiche.dart';
import 'package:http/http.dart' as http;


class CkEnteteFicheApi {
  Future<List<Object>> fetchVersions(String? codeT,String? codeType) async {
    try {
      final uri = Uri.parse('https://localhost:44320/api/CkEnteteFiches/');
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
        List<CkEnteteFiche> ckEnteteFicheList = 
        jsonData.map((json) => CkEnteteFiche.fromJson(json)).toList();
        List<String> versions = ckEnteteFicheList
        .map((ckEnteteFiche) => ckEnteteFiche.version).cast<String>()
        .toList();
        return versions;
      } else {
        print('Erreur lors de la récupération des entetes fiches : ${response.statusCode}');
        print('Réponse du serveur : ${response.body}');
        return [];
      }
    } catch(e) {
      print('Erreur lors de la récupération : $e');
      return [];
    }
  }
}