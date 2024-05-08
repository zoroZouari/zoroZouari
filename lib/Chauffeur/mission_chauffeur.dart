
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';


class MissionChauffeur extends StatefulWidget {
  final int idMission;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final String selectedVehicule;
  final String selectedMissionType;
  final String selectedClient;
  final String selectedLieuChargement;
  final String selectedLieuDechargement;
  final String selectedParc;
  final bool diversSelected ;
  final bool carburantSelected ;
  final bool allerSRVideSelected ;
  final bool retourSRVideSelected ;
  final bool allerSRChargeSelected ;
  final bool retourSRChargeSelected ;
  final bool allerSoloSelected ;
  final bool retourSoloSelected ;
  const MissionChauffeur({
    Key ? key,
    required this.diversSelected,
    required this.carburantSelected,
    required this.allerSRVideSelected,
    required this.retourSRVideSelected,
    required this.allerSRChargeSelected,
    required this.allerSoloSelected,
    required this.retourSRChargeSelected,
    required this.retourSoloSelected,
    required this.idMission,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.selectedClient,
    required this.selectedLieuChargement,
    required this.selectedLieuDechargement,
    required this.selectedVehicule,
    required this.selectedParc,
    required this.selectedMissionType,

    }) : super(key: key);

  @override
  State<MissionChauffeur> createState() => _HistoriqueCkState();
}

class _HistoriqueCkState extends State<MissionChauffeur> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime? startTime;
  DateTime? endTime;
  String vehicule = '';
  String selectedMissionType = '';
  int idMission = 0;
  String client= '';
  String lieuChargement = '';
  String selectedLieuDechargement = '';
  bool parc= false ;
  late bool searchPerformed;
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
      body: Container(
        color: Color(0xFFDDECED),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(50.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 193, 197, 224).withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    
                    child: ExpansionTile(
                      title: Text('Id Mission : $idMission',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                      ),
                      
                      childrenPadding: EdgeInsets.zero,
                      tilePadding: EdgeInsets.zero,
                      children:[
                        searchPerformed
                        ? Column(
                          children: [
                            ListTile(
                          title: Text('Date Début : ${startDate.toString()}',
                          style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                          ),
                          subtitle: Text(
                                    'Date Début :${widget.startDate}',
                                  ),
                        ),
                        
                        ListTile(
                          title: Text('Date Fin : ${endDate.toString()}',
                          style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                          ),
                          subtitle: Text(
                                    'Date Fin :${widget.endDate}',
                                  ),
                        ),
                            ListTile(
                              title: Text('Heure Début : ${startTime.toString()}',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                              subtitle: Text(
                                    'Heure Début :${widget.startTime}',
                                  ),
                            ),
                            ListTile(
                              title: Text('Heure Fin : ${endTime.toString()}',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                              subtitle: Text(
                                    'Heure fin :${widget.endTime}',
                                  ),
                            ),
                            ListTile(
                              title: Text('Vehicule : $vehicule',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                              subtitle: Text(
                                    'Véhicule :${widget.selectedVehicule}',
                                  ),
                            ),
                            ListTile(
                              title: Text('Type Mission : $selectedMissionType',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                              subtitle: Text(
                                    'Type Mission :${widget.selectedMissionType}',
                                  ),
                            ),
                            ListTile(
                                  title: Text('Client : $client',
                                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                                  ),
                                  subtitle: Text(
                                    'Client :${widget.selectedClient}'
                                  ),
                                ),
                                ListTile(
                                  title: Text('Lieu De Chargement : $selectedLieuDechargement',
                                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                                  ),
                                  subtitle: Text(
                                    'Lieu de chargement :${widget.selectedLieuChargement}',
                                  ),
                                ),
                                ListTile(
                                  title: Text('Lieu De Déchargement : $selectedLieuDechargement',
                                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                                  ),
                                  subtitle: Text(
                                    'Lieu de déchargement :${widget.selectedLieuDechargement}',
                                  ),
                                ),
                                ListTile(
                                  title: Text('Parc: $parc',
                                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                                  ),
                                  subtitle: Text(
                                    'Parc :${widget.selectedParc}',
                                  ),
                                ),
                                SizedBox(height:16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.pushNamed(
                                        context,
                                         AppRoutes.modif_ck,
                                         arguments: {
                                          'Id Mission' : idMission,
                                          'Type Mission': 'Exploitation',
                                          'ordre' : 6,
                                         }
                                         );

                                    }, 
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
                                    
                                  ],
                                )
                          ],
                        )
                        : Container(),
                      ],
                       ),
                  ),
                  ),
              ],
            )
          ),
        ),
      ),
    );
  }
}