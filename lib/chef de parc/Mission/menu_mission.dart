
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';





class MenuMission extends StatelessWidget {
  
  const MenuMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDDECED),
        child :  Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
             Column(
              
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                        icon:
                        Icon( Icons.create, size:40),
                      onPressed: (){
                         Navigator.pushNamed(context, AppRoutes.mission_form);
                      },
                      ),
                      Text(
                        'Créer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                    ],
                ),
                /////////////////////////////////////////////////
              IconButton(
                        icon:
                        Icon( Icons.history, size:40),
                      onPressed: (){
                         Navigator.pushNamed(context, AppRoutes.historique_mission);
                      },
                      ),
                      Text(
                        'Historique',
                          style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                    ],         
        )
        )
      ),
    );
  }
  }
