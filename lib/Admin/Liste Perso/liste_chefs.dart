import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class ListeChefs extends StatefulWidget {
  const ListeChefs({super.key});

  @override
  State<ListeChefs> createState() => _ListeChefsState();
}

class _ListeChefsState extends State<ListeChefs> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Liste des Chefs de Parcs',
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
              leading: Icon(Icons.admin_panel_settings_outlined,
              size: 40,
              ), // Remplacement du texte par l'icône
              title: Text(
                'Klay Lewis',
                style: TextStyle(
                  color: Color(0xFF112F33), // Couleur du texte
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
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