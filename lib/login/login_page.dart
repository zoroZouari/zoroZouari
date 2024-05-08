
import 'package:firstparc/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
     resizeToAvoidBottomInset: false,
      body:
      Container(
        decoration: const BoxDecoration(          
        color: Color(0xFFDDECED),
        ),
        child: Column(
          children:  [
            
            const Expanded (child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                 padding: EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 20,
                  ),
              
                ),
            )),
            Expanded(
              flex:5,
               child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top:40,
                    left: 40,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child:const LoginForm(),
                ),
                Positioned(
                  top:1,
                  left: 120,
                  child: ClipOval(
                    child : Image.asset(
                      'assets/logos/firstparclogo.png',
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    )
                  )
                )
              ],
              
            ),
            ),
          ],
        ),
        ),
    );
  }
}