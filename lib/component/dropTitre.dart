import 'dart:convert';
import 'package:firstparc/Models/CkTitres.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DropTitre extends StatefulWidget {
  
final ValueChanged<String?> onTitreChanged;
 

  DropTitre({Key? key, required this.onTitreChanged}) : super(key: key);

  @override
  _DropTitreState createState() => _DropTitreState();
  
}


class _DropTitreState extends State<DropTitre> {
  String? selectedTitre;
  List<CkTitres> titres = []; // Liste de titres

  @override
  void initState() {
    super.initState();
    fetchTitres(); // Appel à la fonction pour récupérer les titres
  }

  // Fonction pour récupérer les titres depuis l'API
  Future<void> fetchTitres() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/CkTitres');
    try {
      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        setState(() {
          titres = data.map((json) => CkTitres.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des titres : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border:Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: DropdownButtonFormField<CkTitres>(
        value: null, // La valeur sélectionnée initialement, null ou une valeur par défaut
        onChanged: (value) {
          setState(() {
            selectedTitre = value!.codeT.toString(); 
            
            print('Selected Titre: ${selectedTitre}');// Enregistrement de codeT dans selectedTitre
            widget.onTitreChanged(selectedTitre);
          });
          
        },
        items: titres.map((CkTitres titre) {
          return DropdownMenuItem<CkTitres>(
            value: titre,
            child: Text(titre.designation), // Affichage de la désignation dans le menu
          );
        }).toList(),
      ),
    );
  }
}
