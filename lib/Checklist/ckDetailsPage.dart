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
  Map<int, String> codeSsDesignations = {}; // Map to store code SS designations
  Map<int, List<int>> codeContenusMap = {}; // Map to store codeContenus for each codeSs
  Map<int, String> codeContenuDesignationMap = {}; // Map to store codeContenu designations
  TextEditingController textController = TextEditingController();
  List<CkTitres> ckTitres = [];
  bool isLoading = true; // Add a loading state
  bool hasPhoto = false;

  @override
  void initState() {
    super.initState();
    fetchCkTitres();
    fetchCkSousTitres();

    for (var ligne in widget.ckLignes) {
      isCheckedList[ligne.codeContenu] = ligne.etatContenu ?? false;
      textMap[ligne.codeContenu] = ligne.observation ?? '';
    }
  }

  Future<void> fetchCkTitres() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/CkTitres/GetDesignationByCodeT/');

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

  Future<void> fetchCkSousTitres() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/CkSousTitres/GetDesignationByCodeSs/');

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
          for (var json in data) {
            CkSousTitre ckSousTitre = CkSousTitre.fromJson(json);
            codeSsDesignations[ckSousTitre.codeSs] = ckSousTitre.designation;

            // Fetch codeContenus for this codeSs
            fetchCodeContenu(ckSousTitre.codeSs);
          }
          isLoading = false; // Set loading to false once data is fetched
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des données de CkSousTitre : $e');
      setState(() {
        isLoading = false; // Set loading to false even on error
      });
    }
  }

  Future<void> fetchCodeContenu(int codeSs) async {
    var url = Uri.parse('https://10.0.2.2:7116/api/CkLigneFiches/GetCodeContenusByCodeSs/$codeSs');

    try {
      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final codeContenus = data.map((e) => e as int).toList();

        setState(() {
          codeContenusMap[codeSs] = codeContenus;
        });

        // Fetch designations for these codeContenus
        await fetchDesignationsForCodeContenus(codeContenus);
      }
    } catch (e) {
      print('Erreur lors de la récupération des codeContenus : $e');
    }
  }

  Future<void> fetchDesignationsForCodeContenus(List<int> codeContenus) async {
    for (var codeC in codeContenus) {
      var url = Uri.parse('https://10.0.2.2:7116/api/CkContenus/GetDesignationByCodeC/$codeC');

      try {
        http.Response response = await http.get(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          final designation = response.body;
          setState(() {
            codeContenuDesignationMap[codeC] = designation;
          });
        } else {
          print('Failed to fetch designation for codeC $codeC: ${response.statusCode}');
        }
      } catch (e) {
        print('Erreur lors de la récupération des désignations de codeC : $e');
      }
    }
  }

  Future<void> _showInputDialog(BuildContext context, int codeContenu) async {
    textController.text = textMap[codeContenu] ?? '';
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
    return codeSsDesignations[codeSs] ?? 'Non trouvé';
  }

  String _getDesignationForCodeC(int codeC) {
    return codeContenuDesignationMap[codeC] ?? 'Non trouvé';
  }

  String _getDesignationForCodeT(int codeT) {
    final ckTitre = ckTitres.firstWhere(
      (element) => element.codeT == codeT,
      orElse: () => CkTitres(designation: 'Non trouvé', codeT: widget.ckEnteteCk.codeT),
    );
    return ckTitre.designation;
  }

  Future<void> _submitUpdates() async {
    List<CkLigneCk> updatedLignes = widget.ckLignes.map((ligne) {
      return CkLigneCk(
        codeCk: ligne.codeCk,
        codeSs: ligne.codeSs,
        codeContenu: ligne.codeContenu,
        etatContenu: isCheckedList[ligne.codeContenu],
        observation: textMap[ligne.codeContenu] ?? '',
        executant: ligne.executant,
      );
    }).toList();

    var url = Uri.parse('https://10.0.2.2:7116/api/CkLigneCks/batchUpdate');
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedLignes.map((e) => e.toJson()).toList()),
      );

      if (response.statusCode == 204) {
        Navigator.of(context).pushNamed('/menu_ck');
      } else {
        print('Failed to update records');
      }
    } catch (e) {
      print('Error updating records: $e');
    }
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
      backgroundColor: Color(0xFFDDECED),
      appBar: AppBar(
        title: Text('Détails du Check List',
        style: TextStyle(
          color: Color(0xFF112F33),
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),
      ),
      body: Center(
        child: isLoading // Show a loading indicator while data is being fetched
            ? CircularProgressIndicator()
            : Padding(
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
                                                      
                                                      color: isCheckedList[ckLigne.codeContenu] ?? false
                                                          ? Colors.green
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Checkbox(
                                                  value: isCheckedList[ckLigne.codeContenu],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isCheckedList[ckLigne.codeContenu] = value!;
                                                    });
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    _showInputDialog(context, ckLigne.codeContenu);
                                                  },
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
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitUpdates,
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF112F33),
                          ),
                          child: Text(
                            'Modifier',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                      ),
                      
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
