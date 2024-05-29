import 'package:firstparc/Models/Utilisateur.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomBox({Key? key, required this.icon, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 77, 113, 137), // Couleur du shadow
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60),
            SizedBox(height: 10),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Alignement du texte au centre
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuAdmin extends StatefulWidget {
  final Utilisateur? utilisateur;
  const MenuAdmin({Key? key, this.utilisateur}) : super(key: key);

  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Admin'),
        actions: [
          PopupMenuButton<int>(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/logos/chef.jpg'),
            ),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black),
                    const SizedBox(width: 8),
                    Text('Modifier Profil'),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    const SizedBox(width: 8),
                    Text('Se Déconnecter'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFDDECED),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // Limiter la largeur de la grille
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              shrinkWrap: true, // Important to use this to limit the grid's height
              children: [
                CustomBox(
                  icon: Icons.people_alt,
                  text: 'Admins',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.liste_admins);
                  },
                ),
                CustomBox(
                  icon: Icons.people_alt,
                  text: 'Chauffeurs',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.liste_chauffs);
                  },
                ),
                CustomBox(
                  icon: Icons.admin_panel_settings_outlined,
                  text: 'Chefs de Parcs',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.liste_chefs);
                  },
                ),
                CustomBox(
                  icon: Icons.build_circle_outlined,
                  text: 'Mécaniciens',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.liste_mecs);
                  },
                ),
                
                CustomBox(
                  icon: Icons.add_road_sharp,
                  text: 'Mission',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.mission_form);
                  },
                ),
                CustomBox(
                  icon: Icons.history,
                  text: 'Historique Mission',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.historique_mission);
                  },
                ),
                CustomBox(
                  icon: Icons.checklist_outlined,
                  text: 'Check List',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.cK);
                  },
                ),
               
                CustomBox(
                  icon: Icons.history,
                  text: 'Historique Check List',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.historique_ck);
                  },
                ),
                 CustomBox(
                  icon: Icons.car_crash_outlined,
                  text: 'Ordre Réparation',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.historique_ordre);
                  },
                ),
                CustomBox(
                  icon: Icons.person_add_alt_1_outlined,
                  text: 'Création Utilisateurs',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.creation_user);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.profil_pageAdmin);
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.login_page);
        break;
    }
  }
}
