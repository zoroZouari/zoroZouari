class CkTypeCks {
 final String designation;
 
 final int codeType;
 /*
 final String libelle;
*/
 CkTypeCks ({
  required this.designation,
  
  required this.codeType,
  /*
  required this.libelle,
  */

 });
factory CkTypeCks.fromJson(Map<String, dynamic> json){
String designation = json['designation'] ?? '';
int codeType = json['codeType'] ?? '';

return CkTypeCks(
  designation: designation, 
  codeType: codeType,

  );
 }
 @override
 String toString()=>designation;
}