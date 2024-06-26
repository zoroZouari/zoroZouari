import 'package:firstparc/Models/Utilisateur.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/services/Utilisateur_api.dart';
import 'package:flutter/material.dart';

class ListeChefs extends StatefulWidget {
  const ListeChefs({super.key});

  @override
  State<ListeChefs> createState() => _ListeChefsState();
}

class _ListeChefsState extends State<ListeChefs> {

late Future<List<Utilisateur>?> _chefs;

 @override
  void initState() {
    super.initState();
    _chefs = UtilisateurApi.fetchChefs();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Liste des Chefs de Parcs',
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
        future: _chefs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun chauffeur trouvé.'));
          }

          final chefs = snapshot.data!;

          return ListView.builder(
            itemCount: chefs.length,
            itemBuilder: (context, index) {
              final chef = chefs[index];
              return Card(
                color: Colors.white, // Couleur de fond de la carte
                child: ListTile(
                  leading: Icon(Icons.people_alt), // Remplacement du texte par l'icône
                  title: Text(
                    '${chef.prenomUser} ${chef.nomUser}', // Affiche le prénom et le nom
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
                        AppRoutes.profil_pageChef,
                        arguments: chef, // Passez l'objet Utilisateur complet
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