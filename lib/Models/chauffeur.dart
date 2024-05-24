class Chauffeur {

 
 final String matriculeC;
 final String prenomC;
 final String nomC;

 Chauffeur ({

  
  required this.matriculeC,
  required this.prenomC,
  required this.nomC,
  

 });
factory Chauffeur.fromJson(Map<String, dynamic> json){
String matriculeC = json['matriculeC'] ?? '';
String prenomC = json['prenomC'] ?? '';
String nomC = json['nomC'] ?? '';

return Chauffeur(
  matriculeC: matriculeC, 
  prenomC: prenomC, 
  nomC: nomC,

  );
  
 }
}