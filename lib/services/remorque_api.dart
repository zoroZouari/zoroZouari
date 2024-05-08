import 'dart:convert';

import 'package:firstparc/Models/remorque.dart';
import 'package:http/http.dart' as http;


class RemorqueApi {
  Future<List<String>> fetchRemorques() async {
    try {
      final uri = Uri.parse('https://10.0.2.2:7116/api/Remorques');
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
        List<Remorque> remorqueList = 
        jsonData.map((json) => Remorque.fromJson(json)).toList();
        List<String> matriculeremorque = remorqueList
        .map((remorque) => remorque.matriculeRem)
        .toList();
        return matriculeremorque;
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