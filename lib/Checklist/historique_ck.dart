
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class HistoriqueCk extends StatefulWidget {
  const HistoriqueCk({Key? key});

  @override
  State<HistoriqueCk> createState() => _HistoriqueCkState();
}

class _HistoriqueCkState extends State<HistoriqueCk> {
  DateTime? startDate;
  DateTime? endDate;
  bool showMenu = false;
   bool searchPerformed = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des Check Lists',
          style: TextStyle(
            color: Color(0xFF112F33),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                showMenu = !showMenu;
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
      backgroundColor: Color(0xFFDDECED),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter widgets go here
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
                child: Column(
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
                    SizedBox(height: 8),
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
                      child: ElevatedButton(
                        onPressed: () {
                          // Action for search
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
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // ListView.builder goes here
            Expanded(
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
                              'Code Ck: ',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              ' Titre : ',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Vehicule :',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Remorque :',
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
                            Navigator.pushNamed(context, AppRoutes.validerMissionChauff);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
          : SizedBox(),
    );
  }
}
