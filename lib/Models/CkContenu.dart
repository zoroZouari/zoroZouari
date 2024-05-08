class CkContenu {

 
 final int codeType;
 final String designation;
 final String codeC;

 CkContenu ({

  
  required this.codeType,
  required this.designation,
  required this.codeC,
  

 });
factory CkContenu.fromJson(Map<String, dynamic> json){
String designation = json['designation'] ?? '';
int codeType = json['codeType'] ?? '';
String codeC = json['codeC'] ?? '';

return CkContenu(
  designation: designation, 
  codeType: codeType, 
  codeC : codeC,

  );
 }
}