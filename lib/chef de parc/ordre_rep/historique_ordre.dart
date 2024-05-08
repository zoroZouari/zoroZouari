
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';


class HistoriqueOrdre extends StatefulWidget {
  const HistoriqueOrdre({super.key});

  @override
  State<HistoriqueOrdre> createState() => _HistoriqueCkState();
}

class _HistoriqueCkState extends State<HistoriqueOrdre> {
  DateTime? startDate;
  DateTime? endDate;
  String filiale = '';
  String id_chauffeur = '';
  String vehicule = '';
  String remorque = '';
  DateTime? date;
  String veh_rem= '';
  String description = '';
 
  bool searchPerformed = false ;
  int idDemande = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            child: IconButton(
              
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pushNamed(context, AppRoutes.menu_mission);
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
                  'Filtre :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF112F33),
                  ),
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
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(onPressed: () {
                      // action pour la recherche
                      setState(() {
                        searchPerformed = true;
                      });
                    },
                    
                     style: ElevatedButton.styleFrom(
                      primary: Color(0xFF112F33),
                      ),
                      child: Text(
                      'Rechercher',
                       style: TextStyle(
                       color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(color: Colors.grey),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 193, 197, 224).withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    
                    child: ExpansionTile(
                      title: Text('Id Demande : $idDemande',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                      ),
                      childrenPadding: EdgeInsets.zero,
                      tilePadding: EdgeInsets.zero,
                      children:[
                        searchPerformed
                        ? Column(
                          children: [
                            ListTile(
                          title: Text('Filiale : $filiale',
                          style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                          ),
                        ),
                        ListTile(
                          title: Text('Id Chauffeur : $id_chauffeur',
                          style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                          ),
                        ),
                            ListTile(
                              title: Text('Vehicule : $vehicule',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                            ),
                            ListTile(
                              title: Text('Remorque : $remorque',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                            ),
                            ListTile(
                              title: Text('Date : ${date.toString()}',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                            ),
                            ListTile(
                              title: Text('Veh/Rem : $veh_rem',
                              style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                              ),
                            ),
                            ListTile(
                                  title: Text('Description panne : $description',
                                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF112F33),
                      ),
                                  ),
                                ),
                                
                                SizedBox(height:16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.pushNamed(
                                        context,
                                         AppRoutes.valider_ordre,
                                         arguments: {
                                          'Id ordre' : idDemande,
                                          
                                         }
                                         );

                                    }, 
                                    style: ElevatedButton.styleFrom(
                                     primary: Color(0xFF112F33),
                                     ),
                                    child: Text(
                                    'Modifier',
                                     style: TextStyle(
                                     color: Colors.white,
                      ),
                    ),
                                    ),
                                    
                                  ],
                                )
                          ],
                        )
                        : Container(),
                      ],
                       ),
                  ),
                  
                  ),
              ],
            )
          ),
        ),
        ],
      ),
      
    );
  }
}