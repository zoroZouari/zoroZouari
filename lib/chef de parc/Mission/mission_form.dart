
import 'dart:convert';

import 'package:firstparc/Models/FaLieuDistance.dart';
import 'package:firstparc/Models/lieuChargement.dart';
import 'package:firstparc/Models/lieuDechargement.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/services/chauffeur_api.dart';
import 'package:firstparc/services/client_api.dart';
import 'package:firstparc/services/remorque_api.dart';
import 'package:firstparc/services/unite_api.dart';
import 'package:firstparc/services/vehicule_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class MissionForm extends StatefulWidget {
  String? codeLieuDepart;
  String? codeLieuArrive;

   MissionForm({Key? key,
  this.codeLieuArrive,
  this.codeLieuDepart,
  }) : super(key: key);

  @override
  State<MissionForm> createState() => _MissionFormState();
}

class _MissionFormState extends State<MissionForm> {

  String? selectedMissionType;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String? selectedVehicule;
  String? selectedChauffeur;
  String? selectedLieuChargement;
  String? selectedLieuDechargement;
  String? selectedClient;
  String? selectedRemorque;
  String? selectedUnite; 
  String? selectedDistance;


   List<String> chauffeurNames = []; // liste des chauffeurs
   List<String> vehicules = []; // Liste des véhicules
   List<String> remorques = []; // Liste des remorques
   List<String> clients = []; // Liste des clients
   List<String> unites = []; // Liste des unités
   List<LieuChargement> lieudechargements = []; // liste des lieux de chargements
   List<LieuDechargement> lieudedechargements = []; // liste des lieux de déchargements
   List<FaLieuDistance> distances = []; // Liste des distances
 
   
@override
  void initState() {
    super.initState();
    fetchChauffeurs();
    fetchVehicules();
    fetchRemorque();
    fetchClients();
    fetchLieuxChargements();
    fetchLieuxDeChargements();
    


  
    
    // Initialisation de la date et de l'heure actuelles
    startDate = DateTime.now();
    startTime = TimeOfDay.now();
  }

 ////////////////////////////////////////////////////  FETCH CHAUFFEURS ///////////////////////////////////
  Future<void> fetchChauffeurs() async {
    ChauffeurApi chauffeurApi = ChauffeurApi();
    List<String> chauffeurName = await chauffeurApi.fetchChauffeurs();
    setState(() {
      chauffeurNames = chauffeurName;
    });
  }
  /////////////////////////////////////// FETCH VEHICULES //////////////////////////////////////////////
   Future<void> fetchVehicules() async {
    VehiculeApi vehiculeApi = VehiculeApi();
    List<String> immatriculation = await vehiculeApi.fetchVehicules();
    setState(() {
      vehicules = immatriculation;
    });
  }
////////////////////////////////////////  fETCH REMORQUES //////////////////////////////////////////////
  Future<void> fetchRemorque() async {
    RemorqueApi remorqueApi = RemorqueApi();
    List<String> matriculeremorque = await remorqueApi.fetchRemorques();
    setState(() {
      remorques = matriculeremorque;
    });
  }
  /////////////////////////////////// FETCH CLIENTS ////////////////////////////////////////////////////
   Future<void> fetchClients() async {
    ClientApi clientApi = ClientApi();
    List<String> nomClient = await clientApi.fetchClients();
    setState(() {
      clients = nomClient;
    });
  }
  ///////////////////////////////////////// Fetch Unité        //////////////////////////////////////////
  Future<void> fetchUnites() async {
    UniteApi uniteApi = UniteApi();
    List<String> desigUnite = await uniteApi.fetchUnites();
    setState(() {
      unites = desigUnite;
    });
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Fonction pour récupérer les lieux depuis l'API
  Future<void> fetchLieuxChargements() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/LieuChargements');
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
          lieudechargements = data.map((json) => LieuChargement.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des lieux de chargements : $e');
    }
  }
  ///////////////////////////////////////////// fetch lieux de déchargements  ///////////////////////////////////////
  Future<void> fetchLieuxDeChargements() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/LieuDechargements');
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
          lieudedechargements = data.map((json) => LieuDechargement.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des lieux de déchargements : $e');
    }
  }
  //////////////////////////////////////// FETCH DISTANCE KM      //////////////////////////////////////////
   // Fonction pour récupérer les versions depuis l'API
  Future<void> fetchDistance() async {
    
    var url = Uri.parse('https://10.0.2.2:7116/api/FaLieuDistances/${widget.codeLieuDepart}/${widget.codeLieuArrive}');

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
          distances = data.map((json) => FaLieuDistance.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des distances : $e');
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              SizedBox(height: 16),
              Text('Type mission :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),),
              DropdownButton<String>(
                value: selectedMissionType,
                onChanged: (value) {
                  setState(() {
                    selectedMissionType = value;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'Exploitation',
                    child: Text('Exploitation'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Entretien',
                    child: Text('Entretien'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Ordre Mission',
                    child: Text('Ordre Mission'),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Date du début :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(onPressed: () async {
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
                     child: Text(startDate != null
                     ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                     :'Choisir',
                     ),
                     ),
                  ],
                  ),
                  SizedBox(height:8),
                  Row(
                    children: [
                      Text(
                        'Date de fin :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF112F33),
                        ),
                        ),
                        SizedBox(width: 22),
                        ElevatedButton(onPressed: () async {
                          final pickedEndDate = await showDatePicker(
                            context: context,
                             initialDate: endDate ?? DateTime.now(),
                             firstDate: DateTime(2000),
                             lastDate: DateTime.now(),
                             );
                             if (pickedEndDate != null) {
                              setState(() {
                                endDate = pickedEndDate;
                              });
                             }    
                        }, 
                        child: Text(endDate != null
                        ? '${endDate!.day}/${endDate!.month}/${endDate!.year}'
                        : 'Choisir',
                        ),
                        ),
                  ],
                  ),
                  SizedBox(height: 8),
                  Row(
                   children: [
                    Text(
                    'Heure de début :',
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF112F33),
                       ),
                       ),
                      SizedBox(width: 10),
                       TextButton(
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
        startTime != null
            ? '${startTime!.hour}:${startTime!.minute}'
            : 'Choisissez l\'heure',
      ),
    ),
  ],
),
SizedBox(height: 8),
Row(
  children: [
    Text(
      'Heure de fin :',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xFF112F33),
      ),
    ),
    SizedBox(width: 22),
    TextButton(
      onPressed: () async {
        final pickedEndTime = await showTimePicker(
          context: context,
          initialTime: endTime ?? TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if (pickedEndTime != null) {
          setState(() {
            endTime = pickedEndTime;
          });
        }
      },
      child: Text(
        endTime != null
            ? '${endTime!.hour}:${endTime!.minute}'
            : 'Choisissez l\'heure',
      ),
    ),
  ],
),
///////////////////////////////////   Clients //////////////////////////////////////////////////
              SizedBox(height: 24),
                const Text(
                        'Client :',
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
                          value: selectedClient,
                          onChanged: (value) {
                            setState(() {
                              selectedClient = value;
                              print('Selected client: $selectedClient');
                            });
                          },
                          items: clients.map((String client) {
                            return DropdownMenuItem<String>(
                              value: client,
                              child: Text(client),
                            );
                          }).toList(),
                        ),
                      ),
  /////////////////////////////////////////////////  Choix De véhicule //////////////////////////////
            SizedBox(height: 24),
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
//////////////////////////////////////////////////   REMORQUES BOX ///////////////////////////////////////
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
 ///////////////////////////////////////////////  choix chauffeur /////////////////////////////////////////////             
              SizedBox(height: 24),
                const Text(
                        'Chauffeur :',
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
                          value: selectedChauffeur,
                          onChanged: (value) {
                            setState(() {
                              selectedChauffeur = value;
                              print('Selected chauffeur: $selectedChauffeur');
                            });
                          },
                          items: chauffeurNames.map((String chauffeurName) {
                            return DropdownMenuItem<String>(
                              value: chauffeurName,
                              child: Text(chauffeurName),
                            );
                          }).toList(),
                        ),
                      ),
/////////////////////////////////////////////////  Choix Unité /////////////////////////////////////////
             SizedBox(height: 24),
                 const Text(
                        'Unité :',
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
                          value: selectedUnite,
                          onChanged: (value) {
                            setState(() {
                              selectedUnite = value;
                              print('Selected Unité: $selectedUnite');
                            });
                          },
                          items: unites.map((String unite) {
                            return DropdownMenuItem<String>(
                              value: unite,
                              child: Text(unite),
                            );
                          }).toList(),
                        ),
                      ),
  /////////////////////////////////////////// CHOIX LIEU DEPART //////////////////////////////////////////
             SizedBox(height: 24),
                Text(
                        'Lieu Départ:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 99, 151, 158),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField<LieuChargement>(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              selectedLieuChargement = value!.codeLieuCharg.toString();
                              widget.codeLieuDepart = value.codeLieuCharg.toString();
                              //selectedTitreDesignation = value.designation; 
                              print('Selected Lieu de chargement: ${selectedLieuChargement}');
                              fetchDistance();
                            });
                          },
                          items: lieudechargements.map((LieuChargement depart) {
                            return DropdownMenuItem<LieuChargement>(
                              value: depart,
                              child: Text(depart.desigLieuCharg),
                            );
                          }).toList(),
                        ),
                      ),
/////////////////////////////////////////////////////  Choix lieu de déchargement /////////////////////////////////
            SizedBox(height: 24),
                  Text(
                        'Lieu arrivé :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField<LieuDechargement>(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              selectedLieuDechargement = value!.codeLieudeCharg.toString();
                              widget.codeLieuArrive = value.codeLieudeCharg.toString();
                              print('Selected lieu de déchargement: ${selectedLieuDechargement}');
                              fetchDistance();
                            });
                          },
                          items: lieudedechargements.map((LieuDechargement arrive) {
                            return DropdownMenuItem<LieuDechargement>(
                              value: arrive,
                              child: Text(arrive.desigLieudeCharg),
                            );
                          }).toList(),
                        ),
                      ),
/////////////////////////////////////////////////   CHOIX DE DISTANCE //////////////////////////////////
                    SizedBox(height: 24),
                Text(
                        'Distance en Km :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField<FaLieuDistance>(
                          value: null,
                          onChanged: (value) {
                            setState(() {
                              selectedDistance = value!.kmDistance.toString();
                              print('Selected distance: ${selectedDistance}');
                            });
                          },
                          items: distances.map((FaLieuDistance kmDistance) {
                            return DropdownMenuItem<FaLieuDistance>(
                              value: kmDistance,
                              child: Text(kmDistance.kmDistance.toString()),
                            );
                          }).toList(),
                        ),
                      ),

                     SizedBox(height: 24),
                Text(
                  ' Région :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),

                
               
   
              SizedBox(height: 16),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.mission_affecte,
                    );
                  },
                  child: Text('Valider',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                  style: ElevatedButton.styleFrom(
                        primary: Color(0xFF112F33),
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


