
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';


class ValiderOrdre extends StatefulWidget {
  const ValiderOrdre({super.key});

  @override
  State<ValiderOrdre> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ValiderOrdre> {
  String? selectedOrgane;
  String? selectedNomMecanicien;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Positioned(
            top: 20,
            left: 0,
            child: IconButton(
              
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pushNamed(context, AppRoutes.menuchefdeparc);
              }, 
              )
          ),
          SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(50.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Id Intervention :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: '123',
                  readOnly: true, 
                ),
                SizedBox(height: 24),
                Text(
                  'Organe :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
                  value: selectedOrgane,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedOrgane = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'Organe ${index +1}',
                        child: Text('Organe ${index + 1}'),
                      );
                      }),
                    ),

                    SizedBox(height: 16),
            Text(
                  'Travail Demandé :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 24),
                Text(
                  'Nom Mécanicien :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
                  value: selectedNomMecanicien,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedNomMecanicien = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'Nom Mécanicien ${index +1}',
                        child: Text('Nom Mécanicien ${index + 1}'),
                      );
                      }),
                    ),
                    SizedBox(height: 16),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.ordre_valide);
                  },
                  child: Text('Valider',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                  style: ElevatedButton.styleFrom(
                        primary: Color(0xFF112F33),
                  ),
                ),
              ),
                


        ],
          )
        
          )
          )
        ]
      )
    );
  }
}