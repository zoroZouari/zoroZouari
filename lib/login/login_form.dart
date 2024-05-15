
import 'package:firstparc/Models/Utilisateur.dart';
import 'package:firstparc/config/app_routes.dart';
import 'package:firstparc/login/text_field_and_title.dart';
import 'package:firstparc/services/Utilisateur_api.dart';
import 'package:flutter/material.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
    final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isHiddenPassword = true;
  bool isCheckBoxEnable = false;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      
      child: Padding(
        
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
             TextFieldAndTitle(
              title: 'Username',
              hintText: 'Enter User ID or Email',
              controller: usernameController,
              validator: (value){
                RegExp regExp =
                RegExp(r'^(?=.{5,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');
                if(value?.isEmpty??true){
                  return "Username is required";
                }else if (value!.length<5){
                  return("Username must have at least 8 char");
                }else if(!regExp.hasMatch(value)){
                  return("Username is weak");
                }
                return null;
               }, 
             ),
            
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: TextFieldAndTitle(
                helperText: 'Password must have at least 1 uppercase Letter and at least 1 lower case, 1 number and 1 special char',
               controller: passwordController,
               validator: (value){
                RegExp regExp =
                RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if(value?.isEmpty??true){
                  return "Password is required";
                }else if (value!.length<8){
                  return("Password must have at least 8 char");
                }else if(!regExp.hasMatch(value)){
                  return("Password is weak, Try another one,Password must have at least 1 uppercase Letter and at least 1 lower case, 1 number and 1 special char");
                }
                return null;
              },
                title: 'Password',
                hintText: 'Enter Password',
                isShowPassword: isHiddenPassword,
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    isHiddenPassword = !isHiddenPassword;
                  });
                }, 
                icon: Icon(
                  isHiddenPassword
                  ? Icons.visibility
                  : Icons.visibility_off,
                color:isHiddenPassword? Colors.black:Colors.red,
                )),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){}, child: Text('Forgot Password',
                  style: TextStyle(
                    fontSize: 18,
                    color:Colors.black45,
                    ),
                    ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10,bottom:40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0,0,0,65),
                        child: Checkbox(
                           activeColor: Color(0xFF749BAC),
                          value: isCheckBoxEnable,
                           onChanged: (value){
                          setState(() {
                            isCheckBoxEnable=value ?? false;
                          });
                        },
                        ),
                      ),
                      Padding (
                        padding: const EdgeInsetsDirectional.fromSTEB(0,0,0,65),
                        child: Text(
                          'Remember Me',
                        style:
                         TextStyle(
                          fontSize: 18,
                          color:Colors.black,
                        ),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (keyForm.currentState!.validate()){
                        final utilisateur = Utilisateur(
                          loginUser: usernameController.text,
                         motPassUser: passwordController.text,
                    
                        
                         );
                         final authentifie = await UtilisateurApi.authenticate(utilisateur);
                         if(authentifie) {

                         print(authentifie);
                        Navigator.pushNamed(context, AppRoutes.menu_ck);

                        print('login done');
                      } else {
                        showDialog(
                          context: (context),
                         builder: (context) => AlertDialog(
                          title: Text('Erreur de connexion'),
                          content: Text('Nom d\'utilisateur ou mot de passe incorrect.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child:Text('OK'),  
                            ),
                          ],
              ),
                         );
                       }
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(6, 50, 68, 1),              
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),

                        )
                      ),
                      child: const Center(
                        child:Text(
                          'Sign in',
                          
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(221, 249, 249, 250),
                          ),      
                        ) ,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
          ),
        ),
        ),
      ),
    );
  }
}