class Utilisateur {
 final String loginUser;
 final String motPassUser;

 Utilisateur ({
  
  required this.loginUser,
  required this.motPassUser,

 });
factory Utilisateur.fromJson(Map<String, dynamic> json){
String loginUser = json['loginUser'] ?? '';
String motPassUser = json['motPassUser'] ?? '';

return Utilisateur(
  loginUser: loginUser, 
  motPassUser: motPassUser,
  );
 }
}