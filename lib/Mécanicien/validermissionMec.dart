import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class ValiderMissionMec extends StatefulWidget {
  @override
  _ValiderMissionMecState createState() => _ValiderMissionMecState();
}

class _ValiderMissionMecState extends State<ValiderMissionMec> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Valider Ordre',
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
                  labelText: 'N° Ordre',
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
                  labelText: 'Organe',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: 'Organe Example',
                readOnly: true,
              ),
              SizedBox(height: 20), // Espacement vertical
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Travail Demandé',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: 'Travail Demandé Example',
                readOnly: true,
              ),
              SizedBox(height: 20), // Espacement vertical
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Observation',
                  labelStyle: TextStyle(
                    color: Color(0xFF112F33), // Couleur du texte
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: 'Observation Example',
                readOnly: true,
              ),
              SizedBox(height: 20), // Espacement vertical
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Validez le formulaire et passez à l'étape suivante
                    Navigator.pushNamed(context, AppRoutes.procederMission);
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
