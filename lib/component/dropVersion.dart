import 'dart:convert';
import 'package:firstparc/Models/CkEntete_fiche.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DropVersion extends StatefulWidget {
  final ValueChanged<String?> onCodeChanged;
  
  final String? codeT;
  final String? codeType;

 
  DropVersion( {
    Key? key,
    
    this.codeT,
    this.codeType,
    required this.onCodeChanged,
  }) : super(key: key);

  @override
  DropVersionState createState() => DropVersionState();
}

class DropVersionState extends State<DropVersion> {
 
  List<CkEnteteFiche> versions = []; // Liste des versions

  @override
  void initState() {
    super.initState();
    // Écoute les changements de codeT et codeType et appelle fetchVersions lorsque les deux sont non nuls
   //if (widget.codeT != null && widget.codeType != null) {
    
     
   //}
  }

  // Fonction pour récupérer les versions depuis l'API en fonction de codeT et codeType
  Future<void> fetchVersions() async {
   
    //var url = Uri.parse('https://localhost:7116/api/CkEnteteFiches/${widget.codeT}/${widget.codeType}');
    var url = Uri.parse('https://10.0.2.2:7116/api/CkEnteteFiches/${widget.codeT}/${widget.codeType}');
    //var url = Uri.parse('https://10.0.2.2:7116/api/CkEnteteFiches/1/1');
    print(url);

    try {
      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        print(response.body);
        setState(() {
          versions = data.map((json) => CkEnteteFiche.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des versions : $e');
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
      child: DropdownButtonFormField<CkEnteteFiche>(
        value: null, // La valeur sélectionnée initialement, null ou une valeur par défaut
        onChanged: (value) {
          
             fetchVersions();
            final selectedVersion = value!.version.toString();
            widget.onCodeChanged(selectedVersion);
            
            print('Selected Version: ${selectedVersion}'); 
          
          
        
        },
        
        items: versions.map((CkEnteteFiche version) {
          return DropdownMenuItem<CkEnteteFiche>(
            value: version,
            child: Text(version.version.toString()), // Affichage de la version dans le menu
          );
        }).toList(),
      ),
    );
  }
}
