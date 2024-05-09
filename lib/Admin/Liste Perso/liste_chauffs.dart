import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class ListeChauffs extends StatefulWidget {
  const ListeChauffs({Key? key});

  @override
  State<ListeChauffs> createState() => _ListeChauffsState();
}

class _ListeChauffsState extends State<ListeChauffs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des chauffeurs',
        style: TextStyle(
          color: Color(0xFF112F33), // Couleur du texte
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
        ),),
      ),
      backgroundColor: Color(0xFFDDECED), // Couleur de fond de l'interface
      body: ListView.builder(
        itemCount: 6, // Ajustez le nombre d'éléments en fonction de vos données
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white, // Couleur de fond de la carte
            child: ListTile(
              leading: Icon(Icons.people_alt), // Remplacement du texte par l'icône
              title: Text(
                'Klay Lewis',
                style: TextStyle(
                  color: Color(0xFF112F33), // Couleur du texte
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                size: 40,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.profil_page); // Redirection vers la page profil_page
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
