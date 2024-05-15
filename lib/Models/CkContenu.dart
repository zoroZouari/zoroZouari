class CkContenu {

 
 
 final String designation;
 final int codeC;

 CkContenu ({

  
  
  required this.designation,
  required this.codeC,
  

 });
factory CkContenu.fromJson(Map<String, dynamic> json){
String designation = json['designation'] ?? '';
int codeC = json['codeC'] ?? '';

return CkContenu(
  designation: designation,  
  codeC : codeC,

  );
 }
}