import 'dart:convert';
import 'package:firstparc/Models/CkLigneFiche.dart';
import 'package:firstparc/Models/CkSousTitre.dart';
import 'package:firstparc/Models/CkContenu.dart';
import 'package:firstparc/config/app_routes.dart';
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

  Ck1({
    Key? key,
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
  Map<int, bool> isCheckedList = {};
  Map<int, String> textMap = {};
  bool hasPhoto = false;
  List<CkLigneFiche> codeSss = [];
  List<CkSousTitre> ckSousTitres = [];
  Map<int, List<int>> codeContenusMap = {};
  Map<int, String> codeContenuDesignationMap = {};
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCodeSs();
    fetchCkSousTitres();
  }

  Future<void> fetchCodeSs() async {
    var url = Uri.parse(
        'https://10.0.2.2:7116/api/CkLigneFiches/${widget.codet}/${widget.codetype}/${widget.version}');

    try {
      http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        Set<int> seenCodeSs = {};
        setState(() {
          codeSss = data.map((json) => CkLigneFiche.fromJson(json))
              .where((item) => seenCodeSs.add(item.codeSs))
              .toList();
        });
        fetchCodeContenu();
      }
    } catch (e) {
      print('Erreur lors de la récupération des codeSs : $e');
    }
  }

  Future<void> fetchCkSousTitres() async {
    var url = Uri.parse(
        'https://10.0.2.2:7116/api/CkSousTitres/GetDesignationByCodeSs/');

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
          ckSousTitres = data.map((json) => CkSousTitre.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des données de CkSousTitre : $e');
    }
  }

  Future<void> fetchCodeContenu() async {
    for (var ss in codeSss) {
      var url = Uri.parse(
          'https://10.0.2.2:7116/api/CkLigneFiches/GetCodeContenusByCodeSs/${ss.codeSs}');

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
            codeContenusMap[ss.codeSs] = codeContenus;
          });

          // Fetch designations for these codeContenus
          await fetchDesignationsForCodeContenus(codeContenus);
        }
      } catch (e) {
        print('Erreur lors de la récupération des codeContenus : $e');
      }
    }
  }

  Future<void> fetchDesignationsForCodeContenus(List<int> codeContenus) async {
    for (var codeC in codeContenus) {
      var url = Uri.parse(
          'https://10.0.2.2:7116/api/CkContenus/GetDesignationByCodeC/$codeC');

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

  String _getDesignationForCodeSs(int codeSs) {
    final ckSousTitre = ckSousTitres.firstWhere(
      (element) => element.codeSs == codeSs,
      orElse: () => CkSousTitre(designation: 'Non trouvé', codeSs: codeSs),
    );
    return ckSousTitre.designation;
  }

  String _getDesignationForCodeC(int codeC) {
    return codeContenuDesignationMap[codeC] ?? 'Non trouvé';
  }

  @override
  Widget build(BuildContext context) {
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
                 'Date : ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.date))} ${DateFormat('HH:mm').format(DateTime.parse(widget.date))}',                style: TextStyle(
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
                  color: Color(0xFF112F33),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Remorque : ${widget.remorque}',
                style
: TextStyle(
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
                          style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                          ),
                        ),
                        children: [
                          for (var ss in codeSss)
                            Card(
                              child: ExpansionTile(
                                title: Text(_getDesignationForCodeSs(ss.codeSs),
                                 style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                                ),
                                ),
                                children: [
                                  for (var codeContenu in codeContenusMap[ss.codeSs] ?? [])
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              _getDesignationForCodeC(codeContenu),
                                              style: TextStyle(
                                                fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              
                                                color: isCheckedList[codeContenu] ?? false ? Colors.green : null,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Checkbox(
                                            value: isCheckedList[codeContenu] ?? false,
                                            onChanged: (value) {
                                              setState(() {
                                                isCheckedList[codeContenu] = value!;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              textController.text = textMap[codeContenu] ?? '';
                                              await _showInputDialog(context, codeContenu);
                                            },
                                            child: Icon(
                                              Icons.note,
                                              color: textMap[codeContenu] != null ? Colors.green : null,
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
                    Divider(color: Colors.grey),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.ck_soumis);
                      },
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

  Future<void> _showInputDialog(BuildContext context, int codeContenu) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Saisir un texte'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  textMap[codeContenu] = textController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
