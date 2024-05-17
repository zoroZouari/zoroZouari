
class CkEnteteCk{
  
  final int codeCk;
  final int codeT;
  final int type;
  final int version;
  final DateTime? dateCk;
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
     this.dateCk,

  });

  factory CkEnteteCk.fromJson(Map<String, dynamic> json){
int codeCk = json['codeCk'] ?? '';
int codeT = json['codeT'] ?? '';
int type = json['type'] ?? '';
int version = json['version'] ?? '';
 DateTime? dateCk = json['dateCk'] != null ? DateTime.parse(json['dateCk'] as String) : null;
 String heureCk = json['heureCk'] ?? '';
String vehicule = json['vehicule'] ?? '';
String remorque = json['remorque'] ?? '';

return CkEnteteCk(
  codeCk: codeCk, 
  codeT: codeT, 
  type: type,
  version: version,
  dateCk: dateCk,
  heureCk: heureCk,
  vehicule: vehicule,
  remorque: remorque,

  );
 }
}