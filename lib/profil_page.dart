import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _prenomUserController = TextEditingController();
  final _nomUserController = TextEditingController();
  final _loginUserController = TextEditingController();
  final _motPassUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF112F33),
          ),
          ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _prenomUserController,
              decoration: InputDecoration(
                labelText: 'Prenom',
                prefixIcon: Icon(Icons.person), // prenom icon
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nomUserController,
              decoration: InputDecoration(
                labelText: 'Nom',
                prefixIcon: Icon(Icons.person), // nom icon
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _loginUserController,
              decoration: InputDecoration(
                labelText: 'LoginUser',
                prefixIcon: Icon(Icons.supervised_user_circle_outlined), //loginuser icon
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _motPassUserController,
              decoration: InputDecoration(
                labelText: 'MotPassUser',
                prefixIcon: Icon(Icons.password_outlined), // password icon
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 100, right:100),
              child: ElevatedButton(
                onPressed: () {
                  final prenom = _prenomUserController.text;
                  final nom = _nomUserController.text;
                  final loginUser = _loginUserController.text;
                  final motPassUser = _motPassUserController.text;
              
                  // Do something with the input values
                  
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4D7181), // couleur du bouton
                ),
                child: Text(
                  'Editer profile', // texte du bouton
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white, // couleur du texte
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
