class Mecanicien {

 
 final String matriculeM;
 final String prenomM;
 final String nomM;

 Mecanicien ({

  
  required this.matriculeM,
  required this.prenomM,
  required this.nomM,
  

 });
factory Mecanicien.fromJson(Map<String, dynamic> json){
String matriculeM = json['matriculeM'] ?? '';
String prenomM = json['prenomM'] ?? '';
String nomM = json['nomM'] ?? '';

return Mecanicien(
  matriculeM: matriculeM, 
  prenomM: prenomM, 
  nomM: nomM,

  );
  
 }
}