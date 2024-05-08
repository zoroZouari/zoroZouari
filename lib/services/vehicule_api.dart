import 'dart:convert';
import 'package:firstparc/Models/vehicule.dart';
import 'package:http/http.dart' as http;



class VehiculeApi {
  

  Future<List<String>> fetchVehicules() async {
    try {
      
      final uri = Uri.parse('https://10.0.2.2:7116/api/Vehicules');
      

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
        List<Vehicule> vehiculeList = 
        jsonData.map((json) => Vehicule.fromJson(json)).toList();
        List<String> immatriculation = vehiculeList
        .map((vehicule) => vehicule.immatriculationVeh)
        .toList();
        return immatriculation;
      } else {
        print('Erreur lors de la récupération des véhicules : ${response.statusCode}');
        print('Réeponse du serveur : ${response.body}');
        return [];
      }
    } catch(e) {
      print('Erreur lors de la récupération : $e');
      return [];
    }
  }
}