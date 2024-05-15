class CkSousTitre {

 

 final String designation;
 final int codeSs;

 CkSousTitre ({

  
  
  required this.designation,
  required this.codeSs,
  

 });
factory CkSousTitre.fromJson(Map<String, dynamic> json){
String designation = json['designation'] ?? '';
int codeSs = json['codeSs'] ?? '';

return CkSousTitre(
  designation: designation, 
  codeSs : codeSs,

  );
 }
  @override
 String toString()=>designation;
}