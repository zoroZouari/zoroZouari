import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';

class CreationUser extends StatefulWidget {
  const CreationUser({Key? key}) : super(key: key);

  @override
  State<CreationUser> createState() => _CreationUserState();
}

class _CreationUserState extends State<CreationUser> {
  final _formKey = GlobalKey<FormState>();

  String? _nom, _prenom, _numeroTel, _email, _motDePasse;
  bool _isChauffeur = false,
      _isMecanicien = false,
      _isChefDeParc = false; // Initialize checkbox values

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
                // TextFormField widgets for user input
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
                    labelText: 'Numéro de téléphone',
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) => _numeroTel = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value,
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

                // CheckboxListTile for selecting user roles
                CheckboxListTile(
                  title: Text(
                    'Chauffeur',
                    style: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: _isChauffeur,
                  onChanged: (value) {
                    setState(() {
                      _isChauffeur = value ?? false;
                      _isMecanicien = false;
                      _isChefDeParc = false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(
                    'Mécanicien',
                    style: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: _isMecanicien,
                  onChanged: (value) {
                    setState(() {
                      _isMecanicien = value ?? false;
                      _isChauffeur = false;
                      _isChefDeParc = false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text(
                    'Chef de parc',
                    style: TextStyle(
                      color: Color(0xFF112F33),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: _isChefDeParc,
                  onChanged: (value) {
                    setState(() {
                      _isChefDeParc = value ?? false;
                      _isChauffeur = false;
                      _isMecanicien = false;
                    });
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          // Call API or perform other actions with the form data
                          Navigator.pushNamed(context, AppRoutes.user_cree);
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
