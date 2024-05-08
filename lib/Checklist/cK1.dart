
import 'package:flutter/material.dart';

class Ck1 extends StatefulWidget {
  const Ck1({Key? key}) : super(key: key);

  @override
  State<Ck1> createState() => _Ck1State();
}

class _Ck1State extends State<Ck1> {
  bool isChecked = false;
  String? inputText;
  bool hasText = false;
  bool hasPhoto = false;
  

  @override
  void initState() {
    super.initState();
    
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFDDECED),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Check liste de :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF112F33),
                ),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112F33),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Version :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 99, 151, 158),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 100), // Espacement entre Date et Rem
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rem :',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF112F33),
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Veh :',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF112F33),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    Card(
                      child: ExpansionTile(
                        title: Text(
                          'Titre',
                          style: TextStyle(fontSize: 16),
                        ),
                        children: [
                          Card(
                            child: ExpansionTile(
                              title: Text('Sous titre 1'),
                              children: [
                                ListTile(
                                  
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Contenu',
                                        style: TextStyle(
                                          color: hasText ? Colors.green : null,
                                        ),
                                      ),
                                      Spacer(),
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await _showInputDialog(context);
                                        },
                                        child: Icon(
                                          Icons.note,
                                          color:
                                              hasText ? Colors.green : null,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color:
                                              hasPhoto ? Colors.green : null,
                                        ),
                                        onPressed: () {
                                          // Logique pour ouvrir l'appareil photo
                                          
                                          setState(() {
                                            hasPhoto = true;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF112F33),
                      ),
                      child: Text(
                        'Suivant',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  

  Future<void> _showInputDialog(BuildContext context) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entrer du texte'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: inputText),
                onChanged: (value) {
                  setState(() {
                    inputText = value;
                    hasText = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(hintText: 'Entrez votre texte'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(inputText);
              },
              child: Text('Valider'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        inputText = result;
        hasText = result.isNotEmpty;
      });
    }
  }
}
