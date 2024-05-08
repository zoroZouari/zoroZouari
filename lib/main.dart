import 'dart:io';


import 'package:firstparc/config/generate_routes.dart';
import 'package:flutter/material.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  WidgetsFlutterBinding.ensureInitialized();
   HttpOverrides.global = MyHttpOverrides();

  runApp(
    
    
    
    
    
    const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FirstParc',
      onGenerateRoute: (RouteSettings)=>
      generateRoute().onGenerateRoute(RouteSettings),
      
    );
  }
}