import 'dart:convert';
import 'package:firstparc/Models/CkLigneFiche.dart';
import 'package:firstparc/Models/CkSousTitre.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Ck1 extends StatefulWidget {
  final String date; 
   String version;
  final String remorque;
  final String vehicule;
  final String titre;
  String codet;
   String codetype;
   Ck1({Key? key,
  required this.date,
    required this.version,
    required this.remorque,
    required this.vehicule,
    required this.titre,
    required this.codet,
    required this.codetype,
    }) : super(key: key);

  @override
  State<Ck1> createState() => _Ck1State();
}

class _Ck1State extends State<Ck1> {
  bool isChecked = false;
  String? inputText;
  bool hasText = false;
  bool hasPhoto = false;
  List<CkLigneFiche> codeSss = [];
   List<CkSousTitre> ckSousTitres = [];
  

  @override
  void initState() {
    super.initState();
    fetchCodeSs();
    fetchCkSousTitres();
    
    
    
  }
 
 // Fonction pour récupérer les versions depuis l'API
  Future<void> fetchCodeSs() async {
    
    
    var url = Uri.parse('https://10.0.2.2:7116/api/CkLigneFiches/${widget.codet}/${widget.codetype}/${widget.version}');

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
          // Utilisation d'un ensemble pour éviter les doublons
          final uniqueCodeSs = <int>{};
          for (var json in data) {
            final codeSs = json['codeSs'] as int;
            if (!uniqueCodeSs.contains(codeSs)) {
              uniqueCodeSs.add(codeSs);
              codeSss.add(CkLigneFiche.fromJson(json));
            }
          }
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des codeSs : $e');
    }
  }


  // Fonction pour récupérer les données de CkSousTitre depuis l'API
  Future<void> fetchCkSousTitres() async {
    // Utiliser l'URL appropriée pour récupérer les données de CkSousTitre depuis l'API
    var url = Uri.parse( 'https://10.0.2.2:7116/api/CkSousTitres/GetDesignationByCodeSs/' );
    
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
          // Convertir les données JSON en liste d'objets CkSousTitre
          ckSousTitres = data.map((json) => CkSousTitre.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des données de CkSousTitre : $e');
    }
  }

  // Méthode _getDesignationForCodeSs
  String _getDesignationForCodeSs(int codeSs) {
    // Trouver la designation correspondant au codeSs
    final ckSousTitre = ckSousTitres.firstWhere(
      (element) => element.codeSs == codeSs,
      
      orElse: () => CkSousTitre(designation: 'Non trouvé', codeSs: codeSs),
    );
    return ckSousTitre.designation;
  }

  @override
  Widget build(BuildContext context) {
    print('codet: ${widget.codet}');
    print('codetype: ${widget.codetype}');
    print('version: ${widget.version}');
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [     
              SizedBox(height: 24),
              Text(
                'Date : ${DateFormat('HH:mm').format(DateTime.parse(widget.date))}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF112F33),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Version : ${widget.version}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 99, 151, 158),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Remorque : ${widget.remorque}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF112F33),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Véhicule : ${widget.vehicule}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF112F33),
                ),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Card(
                      child: ExpansionTile(
                        title: Text(
                          '${widget.titre}',
                          style: TextStyle(fontSize: 16),
                        ),
                        children: [
                          for (var ss in codeSss)
                          Card(
                            child: ExpansionTile(
                              title: Text(_getDesignationForCodeSs(ss.codeSs)),
                              children: [                               
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      
                                      Text(
                                        'Contenu',
                                        style: TextStyle(
                                          color: hasText ? Colors.green : null,
                                        ),
                                      ),
                                      Spacer(),
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await _showInputDialog(context);
                                        },
                                        child: Icon(
                                          Icons.note,
                                          color:
                                              hasText ? Colors.green : null,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color:
                                              hasPhoto ? Colors.green : null,
                                        ),
                                        onPressed: () {
                                          // Logique pour ouvrir l'appareil photo
                                          
                                          setState(() {
                                            hasPhoto = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF112F33),
                      ),
                      child: Text(
                        'Suivant',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entrer du texte'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: inputText),
                onChanged: (value) {
                  setState(() {
                    inputText = value;
                    hasText = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(hintText: 'Entrez votre texte'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(inputText);
              },
              child: Text('Valider'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        inputText = result;
        hasText = result.isNotEmpty;
      });
    }
  }
}
