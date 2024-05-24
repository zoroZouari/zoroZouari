class Unite {

 
 final int codeU;
 final String designU;
 

 Unite ({

  
  required this.codeU,
  required this.designU,
 
  

 });
factory Unite.fromJson(Map<String, dynamic> json){
int codeU = json['codeU'] ?? '';
String designU = json['designU'] ?? '';


return Unite(
  codeU: codeU, 
  designU: designU, 
 

  );
  
 }
}