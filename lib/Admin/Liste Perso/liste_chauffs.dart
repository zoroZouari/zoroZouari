import 'package:firstparc/services/Utilisateur_api.dart';
import 'package:flutter/material.dart';
import 'package:firstparc/Models/Utilisateur.dart';
import 'package:firstparc/config/app_routes.dart';

class ListeChauffs extends StatefulWidget {
  const ListeChauffs({Key? key});

  @override
  State<ListeChauffs> createState() => _ListeChauffsState();
}

class _ListeChauffsState extends State<ListeChauffs> {
  late Future<List<Utilisateur>?> _chauffeurs;

  @override
  void initState() {
    super.initState();
    _chauffeurs = UtilisateurApi.fetchChauffeurs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des chauffeurs',
          style: TextStyle(
            color: Color(0xFF112F33), // Couleur du texte
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Color(0xFFDDECED), // Couleur de fond de l'interface
      body: FutureBuilder<List<Utilisateur>?>(
        future: _chauffeurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun chauffeur trouvé.'));
          }

          final chauffeurs = snapshot.data!;

          return ListView.builder(
            itemCount: chauffeurs.length,
            itemBuilder: (context, index) {
              final chauffeur = chauffeurs[index];
              return Card(
                color: Colors.white, // Couleur de fond de la carte
                child: ListTile(
                  leading: Icon(Icons.people_alt), // Remplacement du texte par l'icône
                  title: Text(
                    '${chauffeur.prenomUser} ${chauffeur.nomUser}', // Affiche le prénom et le nom
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
                        AppRoutes.profil_page,
                        arguments: chauffeur, // Passez l'objet Utilisateur complet
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
