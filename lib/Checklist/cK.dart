import 'package:firstparc/component/dropTitre.dart';
import 'package:firstparc/component/dropType.dart';
import 'package:firstparc/component/dropVersion.dart';
import 'package:firstparc/config/app_routes.dart';

import 'package:firstparc/services/mecanicien_api.dart';
import 'package:firstparc/services/remorque_api.dart';
import 'package:firstparc/services/vehicule_api.dart';
import 'package:flutter/material.dart';

class Ck extends StatefulWidget {
  final String date;

  const Ck({
    Key? key,
    required this.date,
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
  List<dynamic> vehicules = [];
  List<dynamic> remorques = [];
  List<dynamic> cktitres = [];
  List<dynamic> cktypes = [];
  List<dynamic> mecanicienNames = [];

  @override
  void initState() {
    super.initState();
    fetchVehicules();
    fetchRemorque();
    fetchMecaniciens();
    // Initialisation de la date et de l'heure actuelles
    startDate = DateTime.now();
    startTime = TimeOfDay.now();
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
                          items: vehicules.isNotEmpty
                              ? vehicules.map((dynamic vehicule) {
                                  return DropdownMenuItem<String>(
                                    value: vehicule,
                                    child: Text(vehicule),
                                  );
                                }).toList()
                              : [],
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
                          items: remorques.isNotEmpty
                              ? remorques.map((dynamic remorque) {
                                  return DropdownMenuItem<String>(
                                    value: remorque,
                                    child: Text(remorque),
                                  );
                                }).toList()
                              : [],
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
                              startTime != null ? '${startTime!.hour}:${startTime!.minute}' : 'Choisissez l\'heure',
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
                      DropTitre(
                        onTitreChanged: (titre) {
                          setState(() {
                            selectedTitre = titre;
                          });
                        },
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
                      DropType(
                        onTypeChanged: (type) {
                          setState(() {
                            selectedType = type;
                          });
                        },
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
                      DropVersion(
                        codeT: selectedTitre,
                        codeType: selectedType,
                        onCodeChanged: (version) {
                          setState(() {
                            selectedVersion = version;
                          });
                        },
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
                          items: mecanicienNames.isNotEmpty
                              ? mecanicienNames.map((dynamic mecanicienName) {
                                  return DropdownMenuItem<String>(
                                    value: mecanicienName,
                                    child: Text(mecanicienName),
                                  );
                                }).toList()
                              : [],
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          print('Titre sélectionné: $selectedTitre');
                          print('Type sélectionné: $selectedType');
                          print('Version sélectionnée: $selectedVersion');
                          Navigator.pushNamed(context, AppRoutes.cK1);
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
