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
        width: MediaQuery.of(context).size.width * 0.4, // Définir la largeur à 40% de la largeur de l'écran
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
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Alignement du texte au centre
            ),
          ],
        ),
      ),
    );
  }
}

class MenuAdmin extends StatefulWidget {
  const MenuAdmin({Key? key}) : super(key: key);

  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            showMenu = !showMenu;
          });
        },
        child: Container(
          color: Color(0xFFDDECED),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Stack(
            children: [
              //avatar in the top left corner
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/logos/chef.jpg'),
                ),
              ),
              if (showMenu)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SizedBox(height: 45),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: IconButton(
                          icon: Icon(Icons.edit), // icone de modif profil
                          onPressed: () {
                            // Action à effectuer lorsque l'icône de modification de profil est cliquée
                            Navigator.pushNamed(context,
                             AppRoutes.profil_page,);
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: IconButton(
                          icon: Icon(Icons.logout), // icone pour se déconnecter
                          onPressed: () {
                            // Action à effectuer lorsque l'icône de déconnexion est cliquée
                             Navigator.pushNamed(context, AppRoutes.login_page);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomBox(
                      icon: Icons.people_alt,
                      text: 'Chauffeurs',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.liste_chauffs);
                      },
                    ),
                    SizedBox(height: 20),
                    CustomBox(
                      icon: Icons.admin_panel_settings_outlined,
                      text: 'Chefs de Parcs',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.liste_chefs);
                      },
                    ),
                    SizedBox(height: 20),
                    CustomBox(
                      icon: Icons.build_circle_outlined,
                      text: 'Mécaniciens',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.liste_mecs);
                      },
                    ),
                    SizedBox(height: 20),
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
            ],
          ),
        ),
      ),
    );
  }
}