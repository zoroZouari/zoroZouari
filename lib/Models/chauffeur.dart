class Chauffeur {

 
 final String matriculeC;
 final String prenomC;
 final String nomC;
final String nomComplet;
 Chauffeur ({

  
  required this.matriculeC,
  required this.prenomC,
  required this.nomC,
  required this.nomComplet,
  

 });
factory Chauffeur.fromJson(Map<String, dynamic> json){
String matriculeC = json['matriculeC'] ?? '';
String prenomC = json['prenomC'] ?? '';
String nomC = json['nomC'] ?? '';
String nomComplet = json['nomComplet'] ?? '';

return Chauffeur(
  matriculeC: matriculeC, 
  prenomC: prenomC, 
  nomC: nomC,
 nomComplet:nomComplet,
  );
  
 }
}