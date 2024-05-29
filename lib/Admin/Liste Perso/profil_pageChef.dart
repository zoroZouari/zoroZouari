import 'package:firstparc/Models/Utilisateur.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/services/Utilisateur_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePageChef extends StatefulWidget {
  final Utilisateur? chef;

  ProfilePageChef({Key? key, this.chef}) : super(key: key);

  @override
  _ProfilePageChefState createState() => _ProfilePageChefState();
}

class _ProfilePageChefState extends State<ProfilePageChef> {
  final _prenomUserController = TextEditingController();
  final _nomUserController = TextEditingController();
  final _loginUserController = TextEditingController();
  final _motPassUserController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.chef != null) {
      _prenomUserController.text = widget.chef!.prenomUser;
      _nomUserController.text = widget.chef!.nomUser;
      _loginUserController.text = widget.chef!.loginUser;
      _motPassUserController.text = widget.chef!.motPassUser;
    }
  }

  @override
  void dispose() {
    _prenomUserController.dispose();
    _nomUserController.dispose();
    _loginUserController.dispose();
    _motPassUserController.dispose();
    super.dispose();
  }
  Future<bool> deleteUtilisateur(int codeUser) async {
  final url = Uri.parse('https://10.0.2.2:7116/api/Utilisateurs/$codeUser');

  try {
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      Navigator.pushNamed(context, AppRoutes.liste_chefs);
      return true; // Suppression réussie
    } else {
      print('Erreur lors de la suppression - StatusCode: ${response.statusCode}');
      return false; // Échec de la suppression
    }
  } catch (e) {
    print('Erreur lors de la suppression de l\'utilisateur : $e');
    return false; // Erreur de connexion ou autre
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
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
                prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nomUserController,
              decoration: InputDecoration(
                labelText: 'Nom',
                prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _loginUserController,
              decoration: InputDecoration(
                labelText: 'LoginUser',
                prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _motPassUserController,
              decoration: InputDecoration(
                labelText: 'MotPassUser',
                prefixIcon: Icon(Icons.password_outlined),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF112F33),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if(widget.chef != null) {
                        final updatedUtilisateur = Utilisateur(
                          codeUser: widget.chef!.codeUser,
                          loginUser: _loginUserController.text,
                          motPassUser: _motPassUserController.text,
                          codeDroit: widget.chef!.codeDroit,
                          nomUser: _nomUserController.text,
                          prenomUser: _prenomUserController.text,
                        );

                        final success = await UtilisateurApi.updateUtilisateur(updatedUtilisateur);

                        if (success != null) {
                          Navigator.pushNamed(context, AppRoutes.profil_modifie);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la mise à jour du profil')));
                        }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4D7181),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Editer profil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                       deleteUtilisateur(widget.chef!.codeUser);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Supprimer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
