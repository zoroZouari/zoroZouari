class Region {

 
 final int codeReg;
 final String designationReg;
 

 Region ({

  
  required this.codeReg,
  required this.designationReg,
 
  

 });
factory Region.fromJson(Map<String, dynamic> json){
int codeReg = json['codeReg'] ?? '';
String designationReg = json['designationReg'] ?? '';


return Region(
  codeReg: codeReg, 
  designationReg: designationReg, 
 

  );
  
 }
}