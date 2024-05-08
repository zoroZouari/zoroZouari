class CkTitres {

 
 final int codeT;
 final String designation;
 final String libelle;

 CkTitres ({

  
  required this.codeT,
  required this.designation,
  required this.libelle,
  

 });
factory CkTitres.fromJson(Map<String, dynamic> json){
String designation = json['designation'] ?? '';
int codeT = json['codeT'] ?? '';
String libelle = json['libelle'] ?? '';

return CkTitres(
  designation: designation, 
  codeT: codeT, 
  libelle: libelle,

  );
  
 }
 @override
 String toString()=>designation;
 
}