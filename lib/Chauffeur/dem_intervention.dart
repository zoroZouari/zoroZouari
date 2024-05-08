
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class DemIntervention extends StatefulWidget {
  const DemIntervention({Key? key});

  @override
  State<DemIntervention> createState() => _MissionFormState();
}

class _MissionFormState extends State<DemIntervention> {
  bool interieurSelected = false;
  bool exterieurSelected = false;
  bool curatifSelected = false;
  bool preventifSelected = false;
  bool remorqueSelected = false;
  bool vehiculeSelected = false;
  int idDemande = 1;
  String? selectedMissionType;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? selectedParc;
  String? selectedClient;
  String? selectedVehicule;
  String? selectedChauffeur;
  String? selectedConvoyeur;
  String? selectedLieuChargement;
  String? selectedLieuDechargement;
  String? selectedOrgane;
  final TextEditingController chauffeurController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              
              SizedBox(height: 16),
              Text('Id Demande : $idDemande',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),
              ),


              SizedBox(height: 16),
              Text('Statut :',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),),
              DropdownButton<String>(
                value: selectedMissionType,
                onChanged: (value) {
                  setState(() {
                    selectedMissionType = value;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'En cours',
                    child: Text('En cours'),
                  ),
                ],
              ),
              SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Date :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(onPressed: () async {
                      final pickedStartDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        );
                        if (pickedStartDate != null) {
                          setState(() {
                            startDate = pickedStartDate;
                          });
                        }
                    },
                     child: Text(startDate != null
                     ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                     :'Choisir',
                     ),
                     ),
                  ],
                  ),
                  
                  SizedBox(height: 8),
                  Row(
                   children: [
                    Text(
                    'Heure :',
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF112F33),
                       ),
                       ),
                      SizedBox(width: 10),
                       TextButton(
                        onPressed: () async {
                         final pickedStartTime = await showTimePicker(
                         context: context,
                           initialTime: startTime ?? TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child) {
                         return MediaQuery(
                            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                             child: child!,
            );
          },
        );
        if (pickedStartTime != null) {
          setState(() {
            startTime = pickedStartTime;
          });
        }
      },
      child: Text(
        startTime != null
            ? '${startTime!.hour}:${startTime!.minute}'
            : 'Choisissez l\'heure',
      ),
    ),
  ],
),
                SizedBox(height: 24),
                Text(
                  'Véhicule :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
                  value: selectedParc,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedParc = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'Parc ${index +1}',
                        child: Text('Parc ${index + 1}'),
                      );
                      }),
                    ),
                    /*
                  // Ajoutez ici les options pour sélectionner une voiture
                  onChanged: (value) {
                    // Implémentez ici la logique de sélection
                  },
                  // Ajoutez ici les valeurs pour les options
                  items: [],
                ),
            */

              SizedBox(height: 24),
                Text(
                  'Remorque :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
                  value: selectedClient,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedClient = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'client ${index +1}',
                        child: Text('Client ${index + 1}'),
                      );
                      }),
                    ),
                    /*
                  // Ajoutez ici les options pour sélectionner une voiture
                  onChanged: (value) {
                    // Implémentez ici la logique de sélection
                  },
                  // Ajoutez ici les valeurs pour les options
                  items: [],
                ),
            */

            SizedBox(height: 24),
                Text(
                  'Nom chauffeur :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  initialValue: 'Nom du chauffeur',
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                // Input pour sélectionner une voiture
                /*DropdownButton<String>(
                  value: selectedVehicule,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedVehicule = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'Vehicule ${index +1}',
                        child: Text('Vehicule ${index + 1}'),
                      );
                      }),
                    ),
                   */
              
              SizedBox(height: 24),
                Text(
                  'Dernier index :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Entrez le dernier index',
                    border: OutlineInputBorder(),
                  ),
                ),
                // Input pour sélectionner une voiture
                /*DropdownButton<String>(
                  value: selectedChauffeur,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedChauffeur = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'Chauffeur ${index +1}',
                        child: Text('Chauffeur ${index + 1}'),
                      );
                      }),
                    ),
                    /*
                  // Ajoutez ici les options pour sélectionner une voiture
                  onChanged: (value) {
                    // Implémentez ici la logique de sélection
                  },
                  // Ajoutez ici les valeurs pour les options
                  items: [],
                ),
            */
            */
             SizedBox(height: 24),
                Text(
                  'Nouveau Index :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Entrez le dernier index',
                    border: OutlineInputBorder(),
                  ),
                ),
                
                // Input pour sélectionner une voiture
               /* DropdownButton<String>(
                  value: selectedConvoyeur,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedConvoyeur = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'Convoyeur ${index +1}',
                        child: Text('Convoyeur ${index + 1}'),
                      );
                      }),
                    ),
                    /*
                  // Ajoutez ici les options pour sélectionner une voiture
                  onChanged: (value) {
                    // Implémentez ici la logique de sélection
                  },
                  // Ajoutez ici les valeurs pour les options
                  items: [],
                ),
            */
            */

             SizedBox(height: 24),
                Text(
                  'ID Chauffeur :',
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),

                // Input pour sélectionner une voiture
               /* DropdownButton<String>(
                  value: selectedLieuChargement,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedLieuChargement = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'LieuDeChargement ${index +1}',
                        child: Text('LieuDeChargement ${index + 1}'),
                      );
                      }),
                    ),
                    /*
                  // Ajoutez ici les options pour sélectionner une voiture
                  onChanged: (value) {
                    // Implémentez ici la logique de sélection
                  },
                  // Ajoutez ici les valeurs pour les options
                  items: [],
                ),
            */
*/
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
                    /*
                  // Ajoutez ici les options pour sélectionner une voiture
                  onChanged: (value) {
                    // Implémentez ici la logique de sélection
                  },
                  // Ajoutez ici les valeurs pour les options
                  items: [],
                ),
            */
            SizedBox(height: 16),
            Text(
                  'Description :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Observation',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Ajouter une photo :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF112F33),
                      ),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt_outlined),
                        onPressed: (){
                          //ouvrir la caméra de tel ici
                          // utiliser la librairie comme 'image_picker'
                          // assurer d'ajouter 'image_picker' a votre fichier pubspec.yaml
                        }, 
                        ),
                ],
                ),


            Row(
                children: [
                  Text('Intérieur',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF112F33),
                  ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: interieurSelected,
                    onChanged: (value) {
                      setState(() {
                        interieurSelected = value!;
                        if ( value == true){
                          exterieurSelected = false;
                        }
                      });
                    },
                  ),
                  
                  SizedBox(width: 16),
                  Text('Extérieur',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF112F33),

                  ),),
                  SizedBox(width: 16),
                  Checkbox(
                    value: exterieurSelected,
                    onChanged: (value) {
                      setState(() {
                        exterieurSelected = value!;
                        if (value == true) {
                          interieurSelected = false;
                        }
                      });
                    },
                  ),
                ],
              ),
//////////////////////////////////////////////////////////////////
              SizedBox(height: 16),
               Row(
                children: [
                  Text('Curatif',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF112F33),
                  ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: curatifSelected,
                    onChanged: (value) {
                      setState(() {
                        curatifSelected = value!;
                        if (value == true){
                          preventifSelected = false;
                        }
                      });
                    },
                  ),
                  
                  SizedBox(width: 16),
                  Text('Préventif',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF112F33),

                  ),
                  ),
                  
                  SizedBox(width: 16),
                  Checkbox(
                    value: preventifSelected,
                    onChanged: (value) {
                      setState(() {
                        preventifSelected = value!;
                        if (value == true) {
                          curatifSelected = false;
                        }
                      });
                    },
                  ),
                ],
              ),
///////////////////////////////////////////////////////////////     
/// SizedBox(height: 16),
               Row(
                children: [
                  Text('Vehicule',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF112F33),
                  ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: vehiculeSelected,
                    onChanged: (value) {
                      setState(() {
                        vehiculeSelected = value!;
                        
                      });
                    },
                  ),
                  
                  SizedBox(width: 16),
                  Text('Remorque',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF112F33),

                  ),
                  ),
                  
                  SizedBox(width: 16),
                  Checkbox(
                    value: remorqueSelected,
                    onChanged: (value) {
                      setState(() {
                        remorqueSelected = value!;
                        
                      });
                    },
                  ),
                ],
              ),



///////////////////////////////////////////////////////////////
              SizedBox(height: 16),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.dem_saisi);
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
          ),
        ),
      ),
    );
  }
  }
