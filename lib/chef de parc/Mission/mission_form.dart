
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';


class MissionForm extends StatefulWidget {
  const MissionForm({Key? key});

  @override
  State<MissionForm> createState() => _MissionFormState();
}

class _MissionFormState extends State<MissionForm> {


bool diversSelected = false;
  bool carburantSelected = false;
  bool allerSRVideSelected = false;
  bool retourSRVideSelected = false;
  bool allerSRChargeSelected = false;
  bool retourSRChargeSelected = false;
  bool allerSoloSelected = false;
  bool retourSoloSelected = false;
  int idMission = 1;
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
              Text('Id Mission : $idMission',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),
              ),


              SizedBox(height: 16),
              Text('Type mission :',
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
                    value: 'Exploitation',
                    child: Text('Exploitation'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Entretien',
                    child: Text('Entretien'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Ordre Mission',
                    child: Text('Ordre Mission'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Divers',
                  style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),
              ),
                  Checkbox(
                    value: diversSelected,
                    onChanged: (value) {
                      setState(() {
                        diversSelected = value!;
                        if (value == true) {
                          carburantSelected = false;
                        }
                      });
                    },
                  ),
                  
                  SizedBox(width: 16),
                  Text('Carburant',
                  style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF112F33),
              ),
                  ),
                  Checkbox(
                    value: carburantSelected,
                    onChanged: (value) {
                      setState(() {
                        carburantSelected = value!;
                        if (value == true) {
                          diversSelected = false;
                        }
                      });
                    },
                  ),                
                ],
              ),
              SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Date du début :',
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
                  SizedBox(height:8),
                  Row(
                    children: [
                      Text(
                        'Date de fin :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF112F33),
                        ),
                        ),
                        SizedBox(width: 22),
                        ElevatedButton(onPressed: () async {
                          final pickedEndDate = await showDatePicker(
                            context: context,
                             initialDate: endDate ?? DateTime.now(),
                             firstDate: DateTime(2000),
                             lastDate: DateTime.now(),
                             );
                             if (pickedEndDate != null) {
                              setState(() {
                                endDate = pickedEndDate;
                              });
                             }    
                        }, 
                        child: Text(endDate != null
                        ? '${endDate!.day}/${endDate!.month}/${endDate!.year}'
                        : 'Choisir',
                        ),
                        ),
                  ],
                  ),
                  SizedBox(height: 8),
                  Row(
                   children: [
                    Text(
                    'Heure de début :',
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
SizedBox(height: 8),
Row(
  children: [
    Text(
      'Heure de fin :',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Color(0xFF112F33),
      ),
    ),
    SizedBox(width: 22),
    TextButton(
      onPressed: () async {
        final pickedEndTime = await showTimePicker(
          context: context,
          initialTime: endTime ?? TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if (pickedEndTime != null) {
          setState(() {
            endTime = pickedEndTime;
          });
        }
      },
      child: Text(
        endTime != null
            ? '${endTime!.hour}:${endTime!.minute}'
            : 'Choisissez l\'heure',
      ),
    ),
  ],
),

SizedBox(height: 24),
                Text(
                  'Sélectionner un Parc :',
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
                  'Sélectionner un client :',
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
                  'Sélectionner une Vehicule :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
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
                  'Sélectionner un chauffeur :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
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
             SizedBox(height: 24),
                Text(
                  'Sélectionner un convoyeur :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
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

             SizedBox(height: 24),
                Text(
                  'Sélectionner Lieu de Chargement :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
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

            SizedBox(height: 24),
                Text(
                  'Sélectionner Lieu de Déchargement :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
                ),
                SizedBox(height: 8),
                // Input pour sélectionner une voiture
                DropdownButton<String>(
                  value: selectedLieuDechargement,
                  onChanged: (value)
                    {
                      setState(() {
                        selectedLieuDechargement = value;
                      });
                      //implémenter logique de séléction
            
                    },
                    // ajouter ici les valeurs pour les options
            
                    items: List.generate(5, (index) {
                      return DropdownMenuItem<String>(
                        value: 'LieuDeDechargement ${index +1}',
                        child: Text('LieudeDechargement ${index + 1}'),
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
            Row(
                children: [
                  Text('Aller S/R chargé',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF112F33),
                  ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: allerSRChargeSelected,
                    onChanged: (value) {
                      setState(() {
                        allerSRChargeSelected = value!;
                        if (value == true) {
                          retourSRChargeSelected = false;
                        }
                      });
                    },
                  ),
                  
                  SizedBox(width: 16),
                  Text('Aller S/R Vide',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF112F33),

                  ),),
                  SizedBox(width: 16),
                  Checkbox(
                    value: allerSRVideSelected,
                    onChanged: (value) {
                      setState(() {
                        allerSRVideSelected = value!;
                        if (value == true){
                          allerSRChargeSelected = false;
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
                  Text('Retour S/R chargé',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF112F33),
                  ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: retourSRChargeSelected,
                    onChanged: (value) {
                      setState(() {
                        retourSRChargeSelected = value!;
                        if (value == true){
                          retourSRVideSelected = false;
                        }
                      });
                    },
                  ),
                  
                  SizedBox(width: 16),
                  Text('Retour S/R Vide',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF112F33),

                  ),
                  ),
                  
                  SizedBox(width: 16),
                  Checkbox(
                    value: retourSRVideSelected,
                    onChanged: (value) {
                      setState(() {
                        retourSRVideSelected = value!;
                        if ( value == true) {
                          retourSRChargeSelected = false;
                        }
                      });
                    },
                  ),
                ],
              ),
///////////////////////////////////////////////////////////////
              SizedBox(height: 16),
               Row(
                children: [
                  Text('Aller en Solo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF112F33),
                  ),
                  ),
                  SizedBox(width: 10),
                  Checkbox(
                    value: allerSoloSelected,
                    onChanged: (value) {
                      setState(() {
                        allerSoloSelected = value!;
                        
                        
                      });
                    },
                  ),
                  
                  SizedBox(width: 16),
                  Text('Retour en Solo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF112F33),

                  ),),
                  SizedBox(width: 16),
                  Checkbox(
                    value: allerSoloSelected,
                    onChanged: (value) {
                      setState(() {
                        allerSoloSelected = value!;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 16),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.mission_affecte,
                    );
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


