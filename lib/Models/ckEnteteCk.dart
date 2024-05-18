
class CkEnteteCk{
  
  final int codeCk;
  final int codeT;
  final int type;
  final int version;
  final String heureCk;
  final String vehicule;
  final String remorque;

  CkEnteteCk({
    
    required this.codeCk,
    required this.codeT,
    required this.type,
    required this.version,
     required this.heureCk,
    required this.vehicule,
    required this.remorque,

  });

  factory CkEnteteCk.fromJson(Map<String, dynamic> json){
int codeCk = json['codeCk'] ?? '';
int codeT = json['codeT'] ?? '';
int type = json['type'] ?? '';
int version = json['version'] ?? '';
 String heureCk = json['heureCk'] ?? '';
String vehicule = json['vehicule'] ?? '';
String remorque = json['remorque'] ?? '';

return CkEnteteCk(
  codeCk: codeCk, 
  codeT: codeT, 
  type: type,
  version: version,
  heureCk: heureCk,
  vehicule: vehicule,
  remorque: remorque,

  );
 }
}