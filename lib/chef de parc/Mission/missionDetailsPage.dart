
import 'dart:convert';

import 'package:firstparc/Models/FaLieuDistance.dart';
import 'package:firstparc/Models/chauffeur.dart';
import 'package:firstparc/Models/client.dart';
import 'package:firstparc/Models/lieuChargement.dart';
import 'package:firstparc/Models/lieuDechargement.dart';
import 'package:firstparc/Models/mission.dart';
import 'package:firstparc/services/chauffeur_api.dart';

import 'package:firstparc/services/region_api.dart';
import 'package:firstparc/services/remorque_api.dart';
import 'package:firstparc/services/unite_api.dart';
import 'package:firstparc/services/vehicule_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:intl/intl.dart';

class MissionDetailsPage extends StatefulWidget {
 final Mission mission;
 final List<Mission> missiona;



   MissionDetailsPage({Key? key,
   required this.mission,
   required this.missiona,

  
  }) : super(key: key);

  @override
  State<MissionDetailsPage> createState() => _MissionDetailsPageState();
}

class _MissionDetailsPageState extends State<MissionDetailsPage> {

   String _nbtValue = '';
  String _nbRecepValue = '';

   DateTime _selectedDate = DateTime.now();
   DateTime _selectedDate1 = DateTime.now();

   DateTime _selectedDateD = DateTime.now();
   DateTime _selectedDateF = DateTime.now();



  String? selectedMissionType;
  int? selectedEtatMission;
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
  String? selectedRegion;
 


  List<Chauffeur> chauffeurNames = [];
   Map<String, String> chauffeurMap = {};
   List<String> vehicules = []; // Liste des véhicules
   List<String> remorques = []; // Liste des remorques
   List<Client> clients = []; // Liste des clients
   List<String> unites = []; // Liste des unités
   List<LieuChargement> lieudechargements = []; // liste des lieux de chargements
   List<LieuDechargement> lieudedechargements = []; // liste des lieux de déchargements
   List<FaLieuDistance> distances = []; // Liste des distances
   List<String> regions = []; // Liste des régions
   List<Mission> btvalues = [];
 
   
@override
  void initState() {
    super.initState();
    fetchChauffeurs();
    fetchVehicules();
    fetchRemorque();
    fetchClients();
    fetchLieuxChargements();
    fetchLieuxDeChargements();
    fetchRegions();
    fetchAndIncrementBtValues();
        Mission? xClient = widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

    selectedClient = xClient.tCodeCl.toString();

        Mission? xRegion = widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

    selectedRegion = xRegion.codeReg.toString();
  
    // Initialisation de la date et de l'heure actuelles
    startDate = DateTime.now();
    startTime = TimeOfDay.now();
  }

 ////////////////////////////////////////////////////  FETCH CHAUFFEURS ///////////////////////////////////
    Future<void> fetchChauffeurs() async {
    ChauffeurApi chauffeurApi = ChauffeurApi();
    List<Chauffeur> chauffeurs = await chauffeurApi.fetchChauffeurs();
    setState(() {
      chauffeurNames = chauffeurs;
      chauffeurMap = {
        for (var chauffeur in chauffeurs)
          chauffeur.matriculeC: chauffeur.nomComplet
      };
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
  //  Future<void> fetchClients() async {
  //   ClientApi clientApi = ClientApi();
  //   List<String> nomClient = await clientApi.fetchClients();
  //   setState(() {
  //     clients = nomClient;
  //   });
  // }
  // Fonction pour récupérer les lieux depuis l'API
  Future<void> fetchClients() async {
    var url = Uri.parse('https://10.0.2.2:7116/api/Clients');
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
          clients = data.map((json) => Client.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erreur lors de la récupération des lieux de chargements : $e');
    }
  }
  ///////////////////////////////////////// Fetch Unité        //////////////////////////////////////////
  Future<void> fetchUnites() async {
    UniteApi uniteApi = UniteApi();
    List<String> desigUnite = await uniteApi.fetchUnites();
    setState(() {
      unites = desigUnite;
    });
  }
  ///////////////////////////////////////////////  RECUPERER LIEUX CHARGEMENTS             ///////////////////////////////////////////////////////////
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
  ////////////////////////////////////////      FETCH DISTANCE KM      //////////////////////////////////////////
   // Fonction pour récupérer les versions depuis l'API
  // Future<void> fetchDistance() async {
    
  //   var url = Uri.parse('https://10.0.2.2:7116/api/FaLieuDistances/${widget.codeLieuDepart}/${widget.codeLieuArrive}');

  //   print(url);

  //   try {
  //     http.Response response = await http.get(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body) as List<dynamic>;
  //       print(response.body);
  //       setState(() {
  //         distances = data.map((json) => FaLieuDistance.fromJson(json)).toList();
  //       });
  //     }
  //   } catch (e) {
  //     print('Erreur lors de la récupération des distances : $e');
  //   }
  // }
  /////////////////////////////////////// Choix Region   ////////////////////////////////////////////
  Future<void> fetchRegions() async {
    RegionApi regionApi = RegionApi();
    List<String> desigregion = await regionApi.fetchRegions();
    setState(() {
      regions = desigregion;
    });
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////
   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        print(_selectedDate);
      });
  }

   Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate1,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate1)
      setState(() {
        _selectedDate1 = picked;
        print(_selectedDate1);
      });
  }
  //////////////////////// DATE DEBUT /////////////////////////////////////////////
   Future<void> _selectDateD(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateD,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDateD) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateD),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateD = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          
        });
         print('Contenu de _selectedDateD: $_selectedDateD');
      }
    }
  }
  //////////////////////////////////////// DATE FIN /////////////////////////////////////
  Future<void> _selectDateF(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateF,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDateF) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateF),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateF = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          
        });
        print('Contenu de _selectedDateF: $_selectedDateF');
      }
    }
  }

  ///////////////////////////////////////////     RECUPERER BT_N_DOC ET BT_N_RECU             //////////////////////////////////////////////////////
  Future<void> fetchAndIncrementBtValues() async {
    
     
       var url = Uri.parse('https://10.0.2.2:7116/api/Missions/LastBtNdocAndBtNrecu');
      
       print(url);
       try {
        http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
       print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final mission = Mission.fromJson(jsonData);

        // Parse values and increment
        int lastBtNdoc = int.tryParse(mission.btNdoc) ?? 0;
        int lastBtNrecu = int.tryParse(mission.btNrecu) ?? 0;

        int newBtNdoc = lastBtNdoc + 1;
        int newBtNrecu = lastBtNrecu + 1;

        setState(() {
           _nbtValue = newBtNdoc.toString();
           _nbRecepValue = newBtNrecu.toString();
           print(_nbtValue);
           print(_nbRecepValue);
        });
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error, e.g., show a snackbar or alert dialog
    }
  }
  /////////////////////////////////// MISE A JOUR ETAT MISSION //////////////////////////
 Future<void> updateMission(int codeMiss, int newStatut) async {
  final url = 'http://10.0.2.2/7116/api/Missions/$codeMiss';
  
  final response = await http.put(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'statutMiss': newStatut,
      // Ajoutez ici les autres champs de la mission que vous souhaitez mettre à jour
    }),
  );

  if (response.statusCode == 204) {
    // Succès
    print('Mission updated successfully');
  } else {
    // Erreur
    print('Failed to update mission. Status code: ${response.statusCode}');
  }
}
  ////////////////////////////////////////     SUPPRIMER MISSION                  ///////////////////////////////////////
  void deleteMission(int codeMiss) async {
  final url = Uri.parse('http://your-api-url/api/Missions/$codeMiss');
  final response = await http.delete(url);

  if (response.statusCode == 204) {
    // Mission deleted successfully
    print('Mission deleted successfully');
  } else {
    // Handle error
    print('Failed to delete mission: ${response.statusCode}');
  }
}
  //////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {

    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    String formattedDate1 = DateFormat('yyyy-MM-dd').format(_selectedDate1);
    String formattedDateD = DateFormat('yyyy-MM-dd     HH:mm').format(_selectedDateD);
    String formattedDateF = DateFormat('yyyy-MM-dd     HH:mm').format(_selectedDateF);

     Mission? xMission = widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xEtatMission= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xDepart= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xArriver= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xVehicule= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xRemorque= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? selectedChauffeur= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xLieuCharg= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xLieuDecharg= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xRegion= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xNbt= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xDateNb= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xNbRecu= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xDateNbRecu= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );

     Mission? xClient= widget.missiona.firstWhere(
      (mission) => mission.codeMiss == widget.mission.codeMiss,
      orElse: () => widget.mission,
    );



    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Mission',
          style: TextStyle(
            color: Color(0xFF112F33),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
////////////////////////////////////////////////   CHOIX MISSION //////////////////////////////////////////
              SizedBox(height: 16),
              Text('Type mission : ${xMission.typeMissionTransport}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),
              ),

//////////////////////////////////////// STATUT MISSION ///////////////////////////////////////////
              SizedBox(height: 16),
              Text('Statut Mission : ${xEtatMission.statutMiss} ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),
              ),
             
 /////////////////////////////////////////////   CHOISIR DATE DEBUT               ////////////////////////////////////             
              SizedBox(height: 16),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            'Date Début : ${xDepart.depart} ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF112F33),
            ),
          ),
        ),
      
      ],
    ),
                   SizedBox(height: 16),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Date Fin : ${xArriver.arriver}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF112F33),
          ),
        ),
       
      ],
    ),
///////////////////////////////////   Clients //////////////////////////////////////////////////
              SizedBox(height: 24),
                  Text(
          'Client : ${xClient.tCodeCl}',
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
            onChanged: (String? newValue) {
              setState(() {
                selectedClient = newValue;
                print('Selected client code: $selectedClient');
              });
            },
            items: clients.map((Client client) {
              return DropdownMenuItem<String>(
                value: client.codeCl.toString(),
                child: Text(client.intituleClient),
              );
            }).toList(),
          ),
        ),
  /////////////////////////////////////////////////  Choix De véhicule //////////////////////////////
            SizedBox(height: 24),
               Text(
                        ' Véhicule :${xVehicule.codeVeh}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      // SizedBox(height: 8),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(color: Colors.black),
                      //     color: Colors.white,
                      //   ),
                      //   child: DropdownButton<String>(
                      //     value: selectedVehicule,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedVehicule = value;
                      //         print('Selected vehicule: $selectedVehicule');
                      //       });
                      //     },
                      //     items: vehicules.map((String vehicule) {
                      //       return DropdownMenuItem<String>(
                      //         value: vehicule,
                      //         child: Text(vehicule),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
//////////////////////////////////////////////////   REMORQUES BOX ///////////////////////////////////////
                    SizedBox(height: 24),
                Text(
                        ' Remorque : ${xRemorque.matriculeRem}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                     
 ///////////////////////////////////////////////  choix chauffeur /////////////////////////////////////////////             
              SizedBox(height: 24),
                 Text(
                        'Chauffeur : ${selectedChauffeur.codeChauff} ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
            //           SizedBox(height: 8),
            //           Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(5),
            //               border: Border.all(color: Colors.black),
            //               color: Colors.white,
            //             ),
            //              child: DropdownButton<String>(
            // value: selectedChauffeur,
            // onChanged: (value) {
            //   setState(() {
            //     selectedChauffeur = value;
            //     print('Selected chauffeur: $selectedChauffeur');
            //   });
            // },
            // items: chauffeurMap.entries.map((entry) {
            //   return DropdownMenuItem<String>(
            //     value: entry.key,
            //     child: Text(entry.value),
            //   );
            // }).toList(),
            //             ),
            //           ),
/////////////////////////////////////////////////  Choix Unité /////////////////////////////////////////
            //  SizedBox(height: 24),
            //      const Text(
            //             'Unité :',
            //             style: TextStyle(
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //               color: Color(0xFF112F33),
            //             ),
            //           ),
                      // SizedBox(height: 8),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(color: Colors.black),
                      //     color: Colors.white,
                      //   ),
                      //   child: DropdownButton<String>(
                      //     value: selectedUnite,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedUnite = value;
                      //         print('Selected Unité: $selectedUnite');
                      //       });
                      //     },
                      //     items: unites.map((String unite) {
                      //       return DropdownMenuItem<String>(
                      //         value: unite,
                      //         child: Text(unite),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
  /////////////////////////////////////////// CHOIX LIEU DEPART //////////////////////////////////////////
             SizedBox(height: 24),
                Text(
                        'Lieu Départ: ${xLieuCharg.tLieuChargement}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      // Container(
                      //   child: DropdownButtonFormField<LieuChargement>(
                      //     value: null,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedLieuChargement = value!.codeLieuCharg.toString();
                      //         widget.codeLieuDepart = value.codeLieuCharg.toString();
                      //         //selectedTitreDesignation = value.designation; 
                      //         print('Selected Lieu de chargement: ${selectedLieuChargement}');
                      //         fetchDistance();
                      //       });
                      //     },
                      //     items: lieudechargements.map((LieuChargement depart) {
                      //       return DropdownMenuItem<LieuChargement>(
                      //         value: depart,
                      //         child: Text(depart.desigLieuCharg),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
/////////////////////////////////////////////////////  Choix lieu de déchargement /////////////////////////////////
            SizedBox(height: 24),
                  Text(
                        'Lieu arrivé : ${xLieuDecharg.tLieuDechargement}',
                        //${mission.tLieuDechargement}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      // Container(
                      //   child: DropdownButtonFormField<LieuDechargement>(
                      //     value: null,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedLieuDechargement = value!.codeLieudeCharg.toString();
                      //         widget.codeLieuArrive = value.codeLieudeCharg.toString();
                      //         print('Selected lieu de déchargement: ${selectedLieuDechargement}');
                      //         fetchDistance();
                      //       });
                      //     },
                      //     items: lieudedechargements.map((LieuDechargement arrive) {
                      //       return DropdownMenuItem<LieuDechargement>(
                      //         value: arrive,
                      //         child: Text(arrive.desigLieudeCharg),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
/////////////////////////////////////////////////   CHOIX DE DISTANCE //////////////////////////////////
                //     SizedBox(height: 24),
                // Text(
                //         'Distance en Km :',
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //           color: Color(0xFF112F33),
                //         ),
                //       ),
                //       Container(
                //         child: DropdownButtonFormField<FaLieuDistance>(
                //           value: null,
                //           onChanged: (value) {
                //             setState(() {
                //               selectedDistance = value!.kmDistance.toString();
                //               print('Selected distance: ${selectedDistance}');
                //             });
                //           },
                //           items: distances.map((FaLieuDistance kmDistance) {
                //             return DropdownMenuItem<FaLieuDistance>(
                //               value: kmDistance,
                //               child: Text(kmDistance.kmDistance.toString()),
                //             );
                //           }).toList(),
                //         ),
                //       ),
///////////////////////////////////////////   CHOIX DE REGION /////////////////////////////////////
                     SizedBox(height: 24),
                  Text(
                        'Région : ${xRegion.codeReg}',
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
                          value: selectedRegion,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRegion = newValue;
                              print('Selected region: $selectedRegion');
                            });
                          },
                          items: regions.map((String region) {
                            return DropdownMenuItem<String>(
                              value: region,
                              child: Text(region),
                            );
                          }).toList(),
                        ),
                      ),
//////////////////////////////////////////////       BT       /////////////////////////////////////////////////////////
     
    SizedBox(height: 24),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'N BT : ${xNbt.btNdoc}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF112F33),
          ),
        ),
        // SizedBox(width: 16),
        // Expanded(
        //   child: Container(
        //     padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        //     decoration: BoxDecoration(
        //               border: Border.all(color: Colors.grey),
        //               borderRadius: BorderRadius.circular(8.0),
        //             ),
        //              child: Text(
        //               _nbtValue,
        //               style: TextStyle(fontSize: 16),
        //             ),
        //   ),
        // ),
      ],
    ),
    SizedBox(height: 16),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Date BT: ${xDateNb.information}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF112F33),
          ),
        ),
        // SizedBox(width: 16),
        // Expanded(
        //   child: Row(
        //     children: [
        //       Text(
        //         formattedDate,
        //         style: TextStyle(fontSize: 16),
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.calendar_today),
        //         onPressed: () => _selectDate(context),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ),
    SizedBox(height: 24),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'N Bon de Réception : ${xNbRecu.btNrecu}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF112F33),
          ),
        ),
        // SizedBox(width: 16),
        // Expanded(
        //   child: Container(
        //    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        //    decoration: BoxDecoration(
        //               border: Border.all(color: Colors.grey),
        //               borderRadius: BorderRadius.circular(8.0),
        //             ),
        //              child: Text(
        //               _nbRecepValue,
        //               style: TextStyle(fontSize: 16),
        //             ),
        //   ),
        // ),
      ],
    ),
    SizedBox(height: 16),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            'Date B. Réception :${xDateNbRecu.lieu}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF112F33),
            ),
          ),
        ),
        // SizedBox(width: 16),
        // Expanded(
        //   child: Row(
        //     children: [
        //       Text(
        //         formattedDate1,
        //         style: TextStyle(fontSize: 16),
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.calendar_today),
        //         onPressed: () => _selectDate1(context),
        //       ),
        //     ],
        //   ),),
        ],
        ),
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////
             SizedBox(height: 16),
Container(
  alignment: Alignment.bottomCenter,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () async {
          // Logique pour valider
          // await updateMissionEtat(widget.mission.codeMiss, 1);
        },
        child: Text(
          'Valider',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF112F33),
        ),
      ),
      SizedBox(width: 16), // Espacement entre les boutons
      ElevatedButton(
        onPressed: () {
          // Logique pour supprimer
          deleteMission(widget.mission.codeMiss);
        },
        child: Text(
          'Supprimer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
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


