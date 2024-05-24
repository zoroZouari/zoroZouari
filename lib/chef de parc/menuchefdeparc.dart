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
                maxLines: 2, // Limiter le nombre de lignes de texte
                overflow: TextOverflow.ellipsis, // Ajouter des points de suspension si le texte est trop long
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuChefDeParc extends StatefulWidget {
  const MenuChefDeParc({Key? key}) : super(key: key);

  @override
  _MenuChefDeParcState createState() => _MenuChefDeParcState();
}

class _MenuChefDeParcState extends State<MenuChefDeParc> {
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
              // Avatar in the top right corner
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
                            Navigator.pushNamed(context, AppRoutes.profil_page);
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // Limiter la largeur de la grille
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    shrinkWrap: true, // Important to use this to limit the grid's height
                    children: [
                      CustomBox(
                        icon: Icons.checklist_rtl_sharp,
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
                        icon: Icons.car_crash_outlined,
                        text: 'Ordre Réparation',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.historique_ordre);
                        },
                      ),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
