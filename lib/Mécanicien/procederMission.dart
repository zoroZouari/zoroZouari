import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class ProcederMission extends StatefulWidget {
  @override
  _ProcederMissionState createState() => _ProcederMissionState();
}

class _ProcederMissionState extends State<ProcederMission> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Procéder Mission',
          style: TextStyle(
            color: Color(0xFF112F33), // Couleur du texte
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 247, 248, 248), // Couleur de fond de l'app bar
      ),
      backgroundColor: Color(0xFFDDECED), // Couleur de fond de l'interface
      body: SingleChildScrollView(
        child: Padding(
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
                    labelText: 'Travail Exécuté', // Changement de label
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33), // Couleur du texte
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the executed work';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Espacement vertical
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Pièces Utilisées', // Changement de label
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33), // Couleur du texte
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the used parts';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an observation';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Espacement vertical
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Validez le formulaire et passez à l'étape suivante
                      Navigator.pushNamed(context, AppRoutes.mec_mission);
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
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Ajout d'un espace en bas pour éviter le recouvrement par le clavier
              ],
            ),
          ),
        ),
      ),
    );
  }
}
