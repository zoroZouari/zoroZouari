import 'package:flutter/material.dart';
import 'package:firstparc/config/app_routes.dart';

class MecMission extends StatefulWidget {
  const MecMission({Key? key});

  @override
  State<MecMission> createState() => _MecMissionState();
}

class _MecMissionState extends State<MecMission> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des Missions',
          style: TextStyle(
            color: Color(0xFF112F33), // Couleur du texte
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                showMenu = !showMenu; // Inverser l'état du menu
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/logos/chef.jpg'),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFDDECED), // Couleur de fond de l'interface
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Colors.white,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'N°Ordre : ',
                        style: TextStyle(
                          color: Color(0xFF112F33),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Veh : ',
                        style: TextStyle(
                          color: Color(0xFF112F33),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Rem :',
                        style: TextStyle(
                          color: Color(0xFF112F33),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.validermissionMec);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // Affichage conditionnel du menu
      floatingActionButton: showMenu
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.mecprofil_page);
                  },
                  child: Icon(Icons.edit, color: Color(0xFF112F33)),
                ),
                SizedBox(height: 16),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login_page);
                  },
                  child: Icon(Icons.logout, color: Color(0xFF112F33)),
                ),
              ],
            )
          : SizedBox(), // Si showMenu est faux, affichez un SizedBox
    );
  }
}
