import 'dart:convert';
import 'package:firstparc/Checklist/cK1.dart';
import 'package:firstparc/Models/CkTitres.dart';
import 'package:firstparc/Models/CkTypesCks.dart';
import 'package:firstparc/Models/CkEntete_fiche.dart';
import 'package:intl/intl.dart';
import 'package:firstparc/services/mecanicien_api.dart';
import 'package:firstparc/services/remorque_api.dart';
import 'package:firstparc/services/vehicule_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ck extends StatefulWidget {
  final String date;
   String? codeT;
 String? codeType;

    Ck({
    Key? key,
    required this.date,
     this.codeT,
    this.codeType,
  }) : super(key: key);

  @override
  State<Ck> createState() => _ConfigCkState();
}

class _ConfigCkState extends State<Ck> {
  DateTime? startDate;
  TimeOfDay? startTime;
  String? selectedRemorque;
  String? selectedVehicule;
  String? selectedVersion;
  String? selectedType;
  String? selectedTitre;
  String? selectedMecanicien;
  String? selectedTitreDesignation;
  List<CkTitres> titres = []; // Liste de titres
  List<CkTypeCks> types = []; // Liste de types
  List<CkEnteteFiche> versions = []; // Liste des versions
  List<String> vehicules = [];
  List<String> remorques = [];
  List<String> mecanicienNames = [];

  @override
  void initState() {
    super.initState();
    fetchVehicules();
    fetchRemorque();
    fetchMecaniciens();
    fetchTitres();
    fetchType();
    
    // Initialisation de la date et de l'heure actuelles
    startDate = DateTime.now();
    startTime = TimeOfDay.now();
  }

  // Fonction pour récupérer les titres depuis l'API
  Future<void> fetchTitres() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/CkTitres');
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
        setState(() {
          titres = data.map((json) => CkTitres.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des titres : $e');
    }
  }

  // Fonction pour récupérer les types depuis l'API
  Future<void> fetchType() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/CkTypeCks');
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
        setState(() {
          types = data.map((json) => CkTypeCks.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des types : $e');
    }
  }

  // Fonction pour récupérer les versions depuis l'API
  Future<void> fetchVersions() async {
    
    var url = Uri.parse('https://10.0.2.2:7116/api/CkEnteteFiches/${widget.codeT}/${widget.codeType}');

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

  Future<void> fetchVehicules() async {
    VehiculeApi vehiculeApi = VehiculeApi();
    List<String> immatriculation = await vehiculeApi.fetchVehicules();
    setState(() {
      vehicules = immatriculation;
    });
  }

  Future<void> fetchRemorque() async {
    RemorqueApi remorqueApi = RemorqueApi();
    List<String> matriculeremorque = await remorqueApi.fetchRemorques();
    setState(() {
      remorques = matriculeremorque;
    });
  }

  Future<void> fetchMecaniciens() async {
    MecanicienApi mecanicienApi = MecanicienApi();
    List<String> mecanicienName = await mecanicienApi.fetchMecaniciens();
    setState(() {
      mecanicienNames = mecanicienName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 26, 99, 158),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Color(0xFFDDECED),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sélectionner une voiture :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                        ),
                        child: DropdownButton<String>(
                          value: selectedVehicule,
                          onChanged: (value) {
                            setState(() {
                              selectedVehicule = value;
                              print('Selected vehicule: $selectedVehicule');
                            });
                          },
                          items: vehicules.map((String vehicule) {
                            return DropdownMenuItem<String>(
                              value: vehicule,
                              child: Text(vehicule),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Selectionner Remorque :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                        ),
                        child: DropdownButton<String>(
                          value: selectedRemorque,
                          onChanged: (value) {
                            setState(() {
                              selectedRemorque = value;
                              print('Selected remorque: $selectedRemorque');
                            });
                          },
                          items: remorques.map((String remorque) {
                            return DropdownMenuItem<String>(
                              value: remorque,
                              child: Text(remorque),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Date :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF112F33),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              final pickedStartDate = await showDatePicker(
                                context: context,
                                initialDate: startDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (pickedStartDate != null) {
                                setState(() {
                                  startDate = pickedStartDate;
                                });
                              }
                            },
                            child: Text(
                              startDate != null
                                  ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                                  : 'Choisir',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Heure :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF112F33),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              final pickedStartTime = await showTimePicker(
                                context: context,
                                initialTime: startTime ?? TimeOfDay.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedStartTime != null) {
                                setState(() {
                                  startTime = pickedStartTime;
                                });
                              }
                            },
                            child: Text(
                              startTime != null ? DateFormat('HH:mm').format(DateTime(0, 1, 1, startTime!.hour, startTime!.minute)) : 'Choisissez l\'heure',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Sélectionner un Titre :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 99, 151, 158),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField<CkTitres>(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              selectedTitre = value!.codeT.toString();
                              widget.codeT = value.codeT.toString();
                              selectedTitreDesignation = value.designation; 
                              print('Selected Titre: ${selectedTitre}');
                              fetchVersions();
                            });
                          },
                          items: titres.map((CkTitres titre) {
                            return DropdownMenuItem<CkTitres>(
                              value: titre,
                              child: Text(titre.designation),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Sélectionner un Type :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField<CkTypeCks>(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value!.codeType.toString();
                              widget.codeType = value.codeType.toString();
                              print('Selected Type: ${selectedType}');
                              fetchVersions();
                            });
                          },
                          items: types.map((CkTypeCks type) {
                            return DropdownMenuItem<CkTypeCks>(
                              value: type,
                              child: Text(type.designation),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Sélectionner une version :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField<CkEnteteFiche>(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              selectedVersion = value!.version.toString();
                              print('Selected Version: ${selectedVersion}');
                            });
                          },
                          items: versions.map((CkEnteteFiche version) {
                            return DropdownMenuItem<CkEnteteFiche>(
                              value: version,
                              child: Text(version.version.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Selectionner un exécutant :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                        ),
                        child: DropdownButton<String>(
                          value: selectedMecanicien,
                          onChanged: (value) {
                            setState(() {
                              selectedMecanicien = value;
                              print('Selected mécanicien: $selectedMecanicien');
                            });
                          },
                          items: mecanicienNames.map((String mecanicienName) {
                            return DropdownMenuItem<String>(
                              value: mecanicienName,
                              child: Text(mecanicienName),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                         
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
        builder: (context) => Ck1(
          date: widget.date,
          version: selectedVersion ?? '', // Assurez-vous que selectedVersion est non null ou fournissez une valeur par défaut appropriée
          remorque: selectedRemorque ?? '', // Assurez-vous que selectedRemorque est non null ou fournissez une valeur par défaut appropriée
          vehicule: selectedVehicule ?? '',
          titre: selectedTitreDesignation ??'',
          codet:selectedTitre ?? '',
          codetype: selectedType ?? '', // Assurez-vous que selectedVehicule est non null ou fournissez une valeur par défaut appropriée
        ),
       ),
        );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
