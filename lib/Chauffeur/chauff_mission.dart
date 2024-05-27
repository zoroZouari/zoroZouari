
import 'package:firstparc/Chauffeur/chauffMissionDetailMission.dart';
import 'package:firstparc/Models/mission.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ChauffMission extends StatefulWidget {
  const ChauffMission({Key? key}) : super(key: key);

  @override
  _ChauffMissionState createState() => _ChauffMissionState();
}

class _ChauffMissionState extends State<ChauffMission> {
  DateTime? startDate;
  DateTime? endDate;
  bool showMenu = false;
  bool searchPerformed = false;
  List<Mission> searchResults = [];
   List<Mission> missiona = [];
 @override
  void initState() {
    super.initState();
   
  }

  Future<void> _fetchData() async {
    if (startDate != null && endDate != null) {
      final response = await http.get(Uri.parse(
          'https://10.0.2.2:7116/api/Missions/ByDateRange?startDate=${startDate!.toIso8601String().split('T')[0]}&endDate=${endDate!.toIso8601String().split('T')[0]}'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          searchResults = jsonData.map((item) => Mission.fromJson(item)).toList();
        });
      } else {
        // Gérer l'erreur
        setState(() {
          searchResults = [];
        });
      }
    }
  }
   

  void _navigateToDetails(Mission mission) async {
    try {
      final response = await http.get(Uri.parse(
        'https://10.0.2.2:7116/api/Missions/byCodeCk/${mission.codeMiss}',
      ));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Mission> missiona = jsonData.map((item) => Mission.fromJson(item)).toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChauffMissionDetailsPage(mission : mission, missiona: missiona),
          ),
        );
      } else {
        print('Error fetching details: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching details: $e');
    }
  }


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des missions',
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
                        ElevatedButton(
                          onPressed: () async {
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
                          child: Text(
                            startDate != null
                                ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                                : 'Choisir',
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
                        ElevatedButton(
                          onPressed: () async {
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
                          child: Text(
                            endDate != null
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
                          _fetchData();
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
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final mission = searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Code Ck: ${mission.codeMiss}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                                ' Type : ${mission.typeMissionTransport}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Véhicule: ${mission.codeVeh}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Remorque: ${mission.matriculeRem}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Date: ${mission.depart}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                            _navigateToDetails(mission);
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
    );
  }
}
