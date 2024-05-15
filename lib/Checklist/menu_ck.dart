import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class MenuCk extends StatelessWidget {
  const MenuCk({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDDECED),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Stack(
          children: [
            // Avatar in the top middle
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/logos/chef.jpg'),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    CustomBox(
                      icon: Icons.checklist_outlined,
                      text: 'Check List',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.cK);
                      },
                    ),
                    SizedBox(height: 20),
                    CustomBox(
                      icon: Icons.history,
                      text: 'Historique',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.historique_ck);
                      },
                    ),
                  ],
                ),
              ),
            ),
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
                        Navigator.pushNamed(context, AppRoutes.chauff_profilPage);
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
          ],
        ),
      ),
    );
  }
}

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
