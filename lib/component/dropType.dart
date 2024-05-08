import 'dart:convert';

import 'package:firstparc/Models/CkTypesCks.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DropType extends StatefulWidget {
  final ValueChanged<String?> onTypeChanged;
 

  DropType({Key? key,required this.onTypeChanged }) : super(key: key);

  @override
  _DropTypeState createState() => _DropTypeState();
}

class _DropTypeState extends State<DropType> {
   String? selectedType;
  List<CkTypeCks> types = []; // Liste de titres
  

  @override
  void initState() {
    super.initState();
    fetchType(); // Appel à la fonction pour récupérer les titres
  }

  // Fonction pour récupérer les titres depuis l'API
  Future<void> fetchType() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/CkTypeCks');
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
          types = data.map((json) => CkTypeCks.fromJson(json)).toList();
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
      child: DropdownButtonFormField<CkTypeCks>(
        value: null, // La valeur sélectionnée initialement, null ou une valeur par défaut
        onChanged: (value) {
          setState(() {
            selectedType = value!.codeType.toString();
            
            print('Selected Type: ${selectedType}'); // Enregistrement de codeT dans selectedTitre
             widget.onTypeChanged(selectedType);
          });
         
        },
        items: types.map((CkTypeCks type) {
          return DropdownMenuItem<CkTypeCks>(
            value: type,
            child: Text(type.designation), // Affichage de la désignation dans le menu
          );
        }).toList(),
      ),
    );
  }
}
