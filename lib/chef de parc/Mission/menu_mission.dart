import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class MenuMission extends StatelessWidget {
  
  const MenuMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDDECED),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
              CustomBox(
                icon: Icons.create,
                text: 'Créer',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.mission_form);
                },
              ),
              SizedBox(height: 20),
              CustomBox(
                icon: Icons.history,
                text: 'Historique',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.historique_mission);
                },
              ),
            ],
          ),
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
