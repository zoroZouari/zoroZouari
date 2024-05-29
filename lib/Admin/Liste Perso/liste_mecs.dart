
import 'package:firstparc/Models/Utilisateur.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/services/Utilisateur_api.dart';
import 'package:flutter/material.dart';

class ListeMecs extends StatefulWidget {
  const ListeMecs({super.key});

  @override
  State<ListeMecs> createState() => _ListeMecsState();
}

class _ListeMecsState extends State<ListeMecs> {
  late Future<List<Utilisateur>?> _mecs;

  @override
  void initState() {
    super.initState();
    _mecs = UtilisateurApi.fetchMecs();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Liste Des Mécaniciens',
        style: TextStyle(
          color: Color(0xFF112F33), // Couleur du texte
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
        ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.menuAdmin);
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFDDECED), // Couleur de fond de l'interface
      body: FutureBuilder<List<Utilisateur>?>(
        future: _mecs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun mécanicien trouvé.'));
          }

          final mecs = snapshot.data!;

          return ListView.builder(
            itemCount: mecs.length,
            itemBuilder: (context, index) {
              final mec = mecs[index];
              return Card(
                color: Colors.white, // Couleur de fond de la carte
                child: ListTile(
                  leading: Icon(Icons.people_alt), // Remplacement du texte par l'icône
                  title: Text(
                    '${mec.prenomUser} ${mec.nomUser}', // Affiche le prénom et le nom
                    style: TextStyle(
                      color: Color(0xFF112F33), // Couleur du texte
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 40),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.profil_pageMec,
                        arguments: mec, // Passez l'objet Utilisateur complet
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );

  }
}