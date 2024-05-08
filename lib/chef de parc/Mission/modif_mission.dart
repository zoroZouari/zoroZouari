
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';


class ModifMission extends StatefulWidget {
  final int idMission;
  final String typeMission;
  final String nomChauffeur;
  final DateTime date;
  final String nomConvoyeur;
  final String lieuDeChargement;
  final String LieuDeDechargement;
  final String client;

  ModifMission({super.key,
  required this.idMission,
  required this.typeMission,
  required this.nomChauffeur,
  required this.date,
  required this.nomConvoyeur,
  required this.lieuDeChargement,
  required this.LieuDeDechargement,
  required this.client,
  });

  @override
  State<ModifMission> createState() => _ModifCkState();
}

class _ModifCkState extends State<ModifMission> {
  late int _idMission;
  late String _typeMission;
  late String _nomChauffeur;
  late DateTime _date;
  late String _nomConvoyeur;
  late String _lieuDeChargement;
  late String _lieuDeDechargement;
  late String _client;

  @override
  void initState(){
    super.initState();
    // initialiser les valeurs modifiables avec les valeurs initiales
    _idMission = widget.idMission;
    _typeMission = widget.typeMission;
    _nomChauffeur = widget.nomChauffeur;
    _date = widget.date;
    _nomConvoyeur = widget.nomConvoyeur;
    _lieuDeChargement = widget.lieuDeChargement;
    _lieuDeDechargement = widget.LieuDeDechargement;
    _client = widget.client;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            'ID Mission : $_idMission}',
              style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF112F33),
            ),
          ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _typeMission.toString()),
              onChanged: (value) {
                setState(() {
                  _typeMission = (int.tryParse(value) ?? 0) as String;
                });
              },
              decoration: InputDecoration(
                labelText: 'Type Mission :',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _nomChauffeur.toString()),
              onChanged: (value) {
                setState(() {
                  _nomChauffeur= (int.tryParse(value) ?? 0) as String;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nom Chauffeur :',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF112F33),
                ),
                ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _date.toString()),
              onChanged: (value) {
                setState(() {
                  // You need to handle parsing the date from string here
                  // _date = DateTime.tryParse(value) ?? DateTime.now();
                  
                });
              },
              decoration: InputDecoration(labelText: 'Date :',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF112F33),
                ),),
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _nomConvoyeur),
              onChanged: (value) {
                setState(() {
                  _nomConvoyeur = value;
                });
              },
              decoration: InputDecoration(labelText: 'Nom Convoyeur :',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF112F33),
                ),
              ),
            ),

            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _lieuDeChargement),
              onChanged: (value) {
                setState(() {
                  _lieuDeChargement = value;
                });
              },
              decoration: InputDecoration(labelText: 'Lieu de Chargement :',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF112F33),
                ),
              ),
            ),

            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _lieuDeDechargement),
              onChanged: (value) {
                setState(() {
                  _lieuDeDechargement = value;
                });
              },
              decoration: InputDecoration(labelText: 'Lieu de Déchargement : ',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF112F33),
                ),
              ),
            ),

            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _client),
              onChanged: (value) {
                setState(() {
                  _client = value;
                });
              },
              decoration: InputDecoration(labelText: 'Client : ',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF112F33),
                ),
              ),
            ),

            SizedBox(height: 16),
            Center(
              child: ElevatedButton(onPressed:() {
                // action when validate button is pressed 
                Navigator.pushNamed(context, AppRoutes.mission_modifie);
              },
               style: ElevatedButton.styleFrom(
                primary: Color(0xFF112F33),
               ),
               child: Text(
                'Valider',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
               ),
            )
          ],
        ),
      ),
    );
  }
}