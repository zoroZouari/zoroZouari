import 'package:firstparc/services/Utilisateur_api.dart';
import 'package:flutter/material.dart';
import 'package:firstparc/Models/Utilisateur.dart';
import 'package:firstparc/config/app_routes.dart';

class ListeAdmins extends StatefulWidget {
  const ListeAdmins({Key? key});

  @override
  State<ListeAdmins> createState() => _ListeAdminsState();
}

class _ListeAdminsState extends State<ListeAdmins> {
  late Future<List<Utilisateur>?> _admins;

  @override
  void initState() {
    super.initState();
    _admins = UtilisateurApi.fetchAdmins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des Admins',
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
        future: _admins,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun chauffeur trouvé.'));
          }

          final admins = snapshot.data!;

          return ListView.builder(
            itemCount: admins.length,
            itemBuilder: (context, index) {
              final admin = admins[index];
              return Card(
                color: Colors.white, // Couleur de fond de la carte
                child: ListTile(
                  leading: Icon(Icons.people_alt), // Remplacement du texte par l'icône
                  title: Text(
                    '${admin.prenomUser} ${admin.nomUser}', // Affiche le prénom et le nom
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
                        AppRoutes.profil_pageAdmin,
                        arguments: admin, // Passez l'objet Utilisateur complet
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
