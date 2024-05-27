
import 'dart:convert';
import 'package:firstparc/Models/FaLieuDistance.dart';
import 'package:firstparc/Models/chauffeur.dart';
import 'package:firstparc/Models/client.dart';
import 'package:firstparc/Models/lieuChargement.dart';
import 'package:firstparc/Models/lieuDechargement.dart';
import 'package:firstparc/Models/mission.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/services/chauffeur_api.dart';
import 'package:firstparc/services/region_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class ChauffMissionDetailsPage extends StatefulWidget {
 final Mission mission;
 final List<Mission> missiona;


   ChauffMissionDetailsPage({Key? key,
   required this.mission,
   required this.missiona,
  
  }) : super(key: key);

  @override
  State<ChauffMissionDetailsPage> createState() => _ChauffMissionDetailsPageState();
}

class _ChauffMissionDetailsPageState extends State<ChauffMissionDetailsPage> {

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
    fetchClients();
    fetchLieuxChargements();
    fetchLieuxDeChargements();
    fetchRegions();

  }
  //////////////////////////////////////////// UPDATE STATUT MISSION /////////////////////
Future<void> updateMissionEtat(int codeMiss, int newStatut) async {
  final url = 'http://10.0.2.2:7116/api/Missions/$codeMiss';
  
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
  /////////////////////////////////// FETCH CLIENTS ////////////////////////////////////////////////////
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
  /////////////////////////////////////// Choix Region   ////////////////////////////////////////////
  Future<void> fetchRegions() async {
    RegionApi regionApi = RegionApi();
    List<String> desigregion = await regionApi.fetchRegions();
    setState(() {
      regions = desigregion;
    });
  }
  ///////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
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
        ],
        ),
/////////////////////////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: 16),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                   //await updateMissionEtat(widget.mission.codeMiss, 1);
                   Navigator.pushNamed(context, AppRoutes.menuChauffeur);
                    
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


