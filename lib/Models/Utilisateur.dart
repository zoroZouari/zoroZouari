class Utilisateur {
 final String loginUser;
 final String motPassUser;
//  final String nomUser;
//  final String prenomUser;
 Utilisateur ({
  
  required this.loginUser,
  required this.motPassUser,
  // required this.nomUser,
  // required this.prenomUser,

 });
factory Utilisateur.fromJson(Map<String, dynamic> json){
String loginUser = json['loginUser'] ?? '';
String motPassUser = json['motPassUser'] ?? '';
// String nomUser = json['nomUser'] ?? '';
// String prenomUser = json['prenomUser'] ?? '';

return Utilisateur(
  loginUser: loginUser, 
  motPassUser: motPassUser,
  // nomUser:nomUser,
  // prenomUser:prenomUser,
  );
 }
}