class CkLigneFiche {

 
 final int codeT;
 final int codeType;
 final int version;
 final int codeSs;
 final int codeContenu;

 CkLigneFiche ({

  
  required this.codeT,
  required this.codeType,
  required this.version,
  required this.codeSs,
  required this.codeContenu,

 });
factory CkLigneFiche.fromJson(Map<String, dynamic> json){
int codeType = json['codeType'] ?? '';
int codeT = json['codeT'] ?? '';
int version = json['version'] ?? '';
int codeSs = json['codeSs'] ?? '';
int codeContenu = json['codeContenu'] ?? '';


return CkLigneFiche(
  codeType: codeType, 
  codeT: codeT, 
  version: version,
  codeSs : codeSs,
  codeContenu: codeContenu,

  );
 }

}