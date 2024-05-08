
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
      onTap: onTap, // Action à effectuer lorsque le CustomBox est cliqué
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent, // Couleur jaune
          borderRadius: BorderRadius.circular(20), // Border radius arrondi
        ),
        padding: EdgeInsets.all(16), // Espacement intérieur
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60), // Icône au centre
            SizedBox(height: 10), // Espacement entre l'icône et le texte
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ), // Style du texte
            ),
          ],
        ),
      ),
    );
  }
}

class MenuChefDeParc extends StatelessWidget {
  const MenuChefDeParc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDDECED),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SizedBox.expand(
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
              Column(
                children: [
                  SizedBox(height: 60), // Espacement entre le CircleAvatar et la grille des icônes
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2, // Nombre de colonnes dans la grille
                      crossAxisSpacing: 20, // Espacement horizontal entre les éléments
                      mainAxisSpacing: 20, // Espacement vertical entre les éléments
                      children: [
                        // Première icône - Check List
                        CustomBox(
                          icon: Icons.checklist_rtl_sharp,
                          text: 'Check List',
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.menu_ck);
                          },
                        ),
                        // Deuxième icône - Ordre Réparation
                        CustomBox(
                          icon: Icons.car_crash_outlined,
                          text: 'Ordre Réparation',
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.historique_ordre);
                          },
                        ),
                        // Troisième icône - Mission
                        CustomBox(
                          icon: Icons.add_road_sharp,
                          text: 'Mission',
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.menu_mission);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}