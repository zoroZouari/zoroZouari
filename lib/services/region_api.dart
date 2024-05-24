import 'dart:convert';
import 'package:firstparc/Models/region.dart';
import 'package:http/http.dart' as http;



class RegionApi {
  

  Future<List<String>> fetchRegions() async {
    try {
      
      final uri = Uri.parse('https://10.0.2.2:7116/api/Regions');
      

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
        List<Region> regionList = 
        jsonData.map((json) => Region.fromJson(json)).toList();
        List<String> nomReg = regionList
        .map((region) => region.designationReg)
        .toList();
        return nomReg;
      } else {
        print('Erreur lors de la récupération des clients: ${response.statusCode}');
        print('Réeponse du serveur : ${response.body}');
        return [];
      }
    } catch(e) {
      print('Erreur lors de la récupération : $e');
      return [];
    }
  }
}