import 'dart:convert';
import 'package:firstparc/Models/client.dart';

import 'package:http/http.dart' as http;



class ClientApi {
  

  Future<List<String>> fetchClients() async {
    try {
      
      final uri = Uri.parse('https://10.0.2.2:7116/api/Clients');
      

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
        List<Client> clientList = 
        jsonData.map((json) => Client.fromJson(json)).toList();
        List<String> nomClient = clientList
        .map((client) => client.intituleClient)
        .toList();
        return nomClient;
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