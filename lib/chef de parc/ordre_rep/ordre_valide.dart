
import 'package:firstparc/config/app_routes.dart';
import 'package:flutter/material.dart';


class OrdreValide extends StatelessWidget {
  const OrdreValide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDECED),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              size: 100,
              color: Color(0xFF112F33),
            ),
            SizedBox(height: 20),
            Text(
              'Ordre validé avec succès',
              style: TextStyle(
              color: Color(0xFF112F33),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: 200),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, AppRoutes.menuchefdeparc);

              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF112F33),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
               ),
               SizedBox(height: 20),
          ],
        ),
      ),
 
    );
  }
}