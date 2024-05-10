import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class ValiderMissionChauff extends StatefulWidget {
  @override
  _ValiderMissionChauffState createState() => _ValiderMissionChauffState();
}

class _ValiderMissionChauffState extends State<ValiderMissionChauff> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Valider Mission',
          style: TextStyle(
            color: Color(0xFF112F33), // Couleur du texte
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFDDECED), // Couleur de fond de l'app bar
      ),
      backgroundColor: Color(0xFFDDECED), // Couleur de fond de l'interface
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20), // Espacement vertical
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Code Mission',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: '12345', // Exemple de valeur initiale
                readOnly: true, // Rendre le champ en lecture seule
              ),
              SizedBox(height: 20), // Espacement vertical
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Type Mission',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: 'type Example',
                readOnly: true,
              ),
              SizedBox(height: 20), // Espacement vertical
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Client',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: 'client Example',
                readOnly: true,
              ),
              SizedBox(height: 20), // Espacement vertical
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lieu de Chargement',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: 'lieu de chargement Example',
                readOnly: true,
              ),
              SizedBox(height: 20), // Espacement vertical
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lieu de Déchargement',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: 'lieu de déchargement Example',
                readOnly: true,
              ),
              SizedBox(height: 20), // Espacement vertical
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validez le formulaire et passez à l'étape suivante
                    Navigator.pushNamed(context, AppRoutes.chauff_mission);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4D7181), // Couleur du bouton
                ),
                child: Text(
                  'Valider',
                  style: TextStyle(
                    color: Colors.white, // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
