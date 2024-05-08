class CkSousTitre {

 
 final int codeT;
 final String designation;
 final String codeSs;

 CkSousTitre ({

  
  required this.codeT,
  required this.designation,
  required this.codeSs,
  

 });
factory CkSousTitre.fromJson(Map<String, dynamic> json){
String designation = json['designation'] ?? '';
int codeT = json['codeT'] ?? '';
String codeSs = json['codeSs'] ?? '';

return CkSousTitre(
  designation: designation, 
  codeT: codeT, 
  codeSs : codeSs,

  );
 }
}