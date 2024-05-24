import 'package:firstparc/Models/CkTitres.dart';
import 'package:firstparc/Models/ckEnteteCk.dart';
import 'package:firstparc/Models/ckLigneCk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ckDetailsPage.dart';


class HistoriqueCk extends StatefulWidget {
  const HistoriqueCk({Key? key}) : super(key: key);

  @override
  _HistoriqueCkState createState() => _HistoriqueCkState();
}

class _HistoriqueCkState extends State<HistoriqueCk> {
  DateTime? startDate;
  DateTime? endDate;
  bool showMenu = false;
  bool searchPerformed = false;
  List<CkEnteteCk> searchResults = [];
   List<CkTitres> ckTitres = [];
 @override
  void initState() {
    super.initState();
    fetchCkTitres();
  }

  Future<void> _fetchData() async {
    if (startDate != null && endDate != null) {
      final response = await http.get(Uri.parse(
          'https://10.0.2.2:7116/api/CkEnteteCks/ByDateRange?startDate=${startDate!.toIso8601String().split('T')[0]}&endDate=${endDate!.toIso8601String().split('T')[0]}'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          searchResults = jsonData.map((item) => CkEnteteCk.fromJson(item)).toList();
        });
      } else {
        // Gérer l'erreur
        setState(() {
          searchResults = [];
        });
      }
    }
  }
   

  void _navigateToDetails(CkEnteteCk ckEnteteCk) async {
    try {
      final response = await http.get(Uri.parse(
        'https://10.0.2.2:7116/api/CkLigneCks/byCodeCk/${ckEnteteCk.codeCk}',
      ));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CkLigneCk> ckLignes = jsonData.map((item) => CkLigneCk.fromJson(item)).toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CkDetailsPage(ckEnteteCk: ckEnteteCk, ckLignes: ckLignes),
          ),
        );
      } else {
        print('Error fetching details: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching details: $e');
    }
  }


 Future<void> fetchCkTitres() async {
  var url = Uri.parse('https://10.0.2.2:7116/api/CkTitres/GetDesignationByCodeT/');

  try {
    http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        ckTitres = data.map((json) => CkTitres.fromJson(json)).toList();
      });
      print('ckTitres fetched successfully: $ckTitres');
    } else {
      print('Failed to load ckTitres: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur lors de la récupération des données de CkTitre : $e');
  }
}


String _getDesignationForCodeT(int codeT) {
  final ckTitre = ckTitres.firstWhere(
    (element) => element.codeT == codeT,
    orElse: () {
      print('Designation not found for codeT: $codeT');
      return CkTitres(designation: 'Non trouvé', codeT: codeT);
    },
  );
  print('Designation found for codeT $codeT: ${ckTitre.designation}');
  return ckTitre.designation;
}
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
                  final ckEnteteCk = searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Code Ck: ${ckEnteteCk.codeCk}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                               _getDesignationForCodeT (ckEnteteCk.codeT),
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Véhicule: ${ckEnteteCk.vehicule}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Remorque: ${ckEnteteCk.remorque}',
                              style: TextStyle(
                                color: Color(0xFF112F33),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Date: ${ckEnteteCk.heureCk}',
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
                            _navigateToDetails(ckEnteteCk);
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
