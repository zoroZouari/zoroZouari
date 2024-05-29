import 'dart:convert';
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreationUser extends StatefulWidget {
  const CreationUser({Key? key}) : super(key: key);

  @override
  State<CreationUser> createState() => _CreationUserState();
}

class _CreationUserState extends State<CreationUser> {
  final _formKey = GlobalKey<FormState>();
  String? _nom, _prenom, _login, _motDePasse;
  int? _codeDroit;

  // Future<void> _createUser() async {
  //   final url = Uri.parse('http://10.0.2.2:7116/api/Utilisateurs'); // Remplacez par l'URL de votre API
  //   print(url);
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
          
  //         'nomUser': _nom,
  //         'prenomUser': _prenom,
  //         'loginUser': _login,
  //         'motPassUser': _motDePasse,
  //         'codeDroit': _codeDroit,
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       print(response.body);
  //       Navigator.pushNamed(context, '/menuAdmin'); // Assurez-vous que vous avez configuré cette route
  //     } else {
  //       // Gérer l'erreur de requête HTTP
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Échec de la création de l\'utilisateur. Code: ${response.statusCode}')),
  //       );
  //     }
  //   } catch (e) {
  //     // Gérer les erreurs de connexion
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Erreur de connexion : $e')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Créer un nouveau utilisateur',
          style: TextStyle(
            color: Color(0xFF112F33),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFDDECED),
      ),
      backgroundColor: Color(0xFFDDECED),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _nom = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) => _prenom = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Code Droit',
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your code droit';
                    }
                    return null;
                  },
                  onSaved: (value) => _codeDroit = int.tryParse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'login',
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid login';
                    }
                    return null;
                  },
                  onSaved: (value) => _login = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  onSaved: (value) => _motDePasse = value,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                         // _createUser(); // Appelez la fonction pour créer l'utilisateur
                         Navigator.pushNamed(context, AppRoutes.menuAdmin);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4D7181),
                      ),
                      child: Text(
                        'Valider',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4D7181),
                      ),
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
