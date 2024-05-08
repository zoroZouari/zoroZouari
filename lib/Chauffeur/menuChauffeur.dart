
import 'package:firstparc/config/app_routes.dart';
import'package:flutter/material.dart';



class MenuChauffeur extends StatelessWidget {
  const MenuChauffeur({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Color(0xFFDDECED),
        child:  Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //avatar at the top in the middle
                 CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/logos/chef.jpg'),
                 ),

                ],
              ),
              
              SizedBox(height: 24),
              
                  ///////////////////////////////////////////////////////////////
                  Column(
                    children: [
                      IconButton(
                        icon:
                        Icon( Icons.car_crash_outlined, size:40),
                      onPressed: (){
                         Navigator.pushNamed(context, AppRoutes.dem_Intervention);
                      },
                      ),
                      Text(
                        'Demande d\'intervention',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                    ],
                  ),

                  ////////////////////////////////////////////////////////////////////
                  Column(
                    children: [
                      IconButton(
                        icon:
                        Icon( Icons.add_road_sharp, size:40),
                      onPressed: (){
                         Navigator.pushNamed(context, AppRoutes.mission_chauffeur,
                         );
                      },
                      ),
                      Text(
                        'Mission',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                    ],
                  ),
                ],
                ),
          
          ),
          ),
        ),
      );
  }
}