import 'dart:convert';
import 'package:firstparc/Models/unite.dart';
import 'package:http/http.dart' as http;


class UniteApi {
  Future<List<String>> fetchUnites() async {
    try {
      final uri = Uri.parse('https://10.0.2.2:7116/api/FaUnites');
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
        List<Unite> uniteList = 
        jsonData.map((json) => Unite.fromJson(json)).toList();
        List<String> designationUnite = uniteList
        .map((unite) => unite.designU)
        .toList();
        return designationUnite;
      } else {
        print('Erreur lors de la récupération des unités : ${response.statusCode}');
        print('Réponse du serveur : ${response.body}');
        return [];
      }
    } catch(e) {
      print('Erreur lors de la récupération : $e');
      return [];
    }
  }
}