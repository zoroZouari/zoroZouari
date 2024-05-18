import 'dart:convert';

import 'package:firstparc/Models/CkSousTitre.dart';
import 'package:firstparc/Models/CkTitres.dart';
import 'package:firstparc/Models/ckEnteteCk.dart';
import 'package:firstparc/Models/ckLigneCk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CkDetailsPage extends StatefulWidget {
  final CkEnteteCk ckEnteteCk;
  final List<CkLigneCk> ckLignes;

  CkDetailsPage({required this.ckEnteteCk, required this.ckLignes});

  @override
  State<CkDetailsPage> createState() => _CkDetailsPageState();
}

class _CkDetailsPageState extends State<CkDetailsPage> {
  Map<int, bool> isCheckedList = {};
  Map<int, String> textMap = {};
  TextEditingController textController = TextEditingController();
  bool hasPhoto = false;
  List<CkTitres> ckTitres = [];

  @override
  void initState() {
    super.initState();
    // Initialiser les valeurs des maps
    for (var ligne in widget.ckLignes) {
      print('CodeContenu: ${ligne.codeContenu}');
      isCheckedList[ligne.codeContenu] = ligne.etatContenu == 'valid'; // ou 'true' selon votre logique
      textMap[ligne.codeContenu] = ligne.observation;
    }
    fetchCkTitres();
  }

  Future<void> _showInputDialog(BuildContext context, int codeContenu) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Observation'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'Observation'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  textMap[codeContenu] = textController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getDesignationForCodeSs(int codeSs) {
    // Replace this with your actual logic to get the designation for codeSs
    return 'Designation for $codeSs';
  }

  String _getDesignationForCodeC(int codeC) {
    // Replace this with your actual logic to get the designation for codeC
    return 'Designation for $codeC';
  }
  ///////////////////////////// Designation by codeT ///////////////////////////////////////////
   Future<void> fetchCkTitres() async {
    var url = Uri.parse(
        'https://10.0.2.2:7116/api/CkTitres/GetDesignationByCodeT/');

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
          ckTitres = data.map((json) => CkTitres.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des données de CkTitre : $e');
    }
  }
  String _getDesignationForCodeT(int codeT) {
    final ckTitre = ckTitres.firstWhere(
      (element) => element.codeT == codeT,
      orElse: () => CkTitres(designation: 'Non trouvé', codeT: widget.ckEnteteCk.codeT),
    );
    return ckTitre.designation;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, List<CkLigneCk>> groupedByCodeSs = {};

    for (var ligne in widget.ckLignes) {
      if (!groupedByCodeSs.containsKey(ligne.codeSs)) {
        groupedByCodeSs[ligne.codeSs] = [];
      }
      groupedByCodeSs[ligne.codeSs]!.add(ligne);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Check List'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code Ck: ${widget.ckEnteteCk.codeCk}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            'Véhicule: ${widget.ckEnteteCk.vehicule}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Remorque: ${widget.ckEnteteCk.remorque}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Date: ${widget.ckEnteteCk.heureCk}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: ListView(

            
            children: [
              Card(
                child: ExpansionTile(
                  title: Text(
                    _getDesignationForCodeT(widget.ckEnteteCk.codeT),
                   // '${widget.ckEnteteCk.codeT}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF112F33),
                    ),
                  ),
                  children: [
                    for (var codeSs in groupedByCodeSs.keys)
                      Card(
                        child: ExpansionTile(
                          title: Text(
                            _getDesignationForCodeSs(codeSs),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF112F33),
                            ),
                          ),
                          children: [
                            for (var ckLigne in groupedByCodeSs[codeSs]!)
                              ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _getDesignationForCodeC(ckLigne.codeContenu),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isCheckedList[ckLigne.codeContenu] ?? false ? Colors.green : null,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Checkbox(
                                      value: ckLigne.etatContenu ?? false,
                                      onChanged: (value) {
                                        setState(() {
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        textController.text = textMap[ckLigne.codeContenu] ?? '';
                                        await _showInputDialog(context, ckLigne.codeContenu);
                                      },
                                      child: Icon(
                                        Icons.note,
                                        color: textMap[ckLigne.codeContenu] != null ? Colors.green : null,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: hasPhoto ? Colors.green : null,
                                      ),
                                      onPressed: () {
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
            ],
          ),
        ),
        ],
      ),
        ),
      ),
    );
  }
}
