

class Mission {
 final int codeMiss;
 final DateTime dateD;
 final DateTime dateF;
 final String codeChauff;
 final String codeVeh;
 final String matriculeRem;
 final String tLieuChargement;
 final String tLieuDechargement;
 final int statutMiss;
 final int codeCl;
 final String typeMissionTransport;
 final String btNdoc;
 final DateTime btDateDoc;
 final String btNrecu;
 final DateTime btDateRecu;
 Mission ({
  
  required this.codeMiss,
  required this.dateD,
  required this.dateF,
  required this.codeChauff,
  required this.codeVeh,
  required this.matriculeRem,
  required this.tLieuChargement,
  required this.tLieuDechargement,
  required this.statutMiss,
  required this.codeCl,
  required this.typeMissionTransport,
  required this.btNdoc,
  required this.btDateDoc,
  required this.btNrecu,
  required this.btDateRecu,

 });
factory Mission.fromJson(Map<String, dynamic> json){
 int codeMiss = json['codeMiss'] ?? 0;
    String codeChauff = json['codeChauff'] ?? '';
    DateTime dateD = json['dateD'] != null ? DateTime.parse(json['dateD']) : DateTime.now();
    DateTime dateF = json['dateF'] != null ? DateTime.parse(json['dateF']) : DateTime.now();
    String codeVeh = json['codeVeh'] ?? '';
    String matriculeRem = json['matriculeRem'] ?? '';
    String tLieuChargement = json['tLieuChargement'] ?? '';
    String tLieuDechargement = json['tLieuDechargement'] ?? '';
    int statutMiss = json['statutMiss'] ?? 0;
    int codeCl = json['codeCl'] ?? 0;
    String typeMissionTransport = json['typeMissionTransport'] ?? '';
    String btNdoc = json['btNdoc'] ?? '';
    DateTime btDateDoc = json['btDateDoc'] != null ? DateTime.parse(json['btDateDoc']) : DateTime.now();
    String btNrecu = json['btNrecu'] ?? '';
    DateTime btDateRecu = json['btDateRecu'] != null ? DateTime.parse(json['btDateRecu']) : DateTime.now();

return Mission(
  codeMiss: codeMiss, 
  codeChauff: codeChauff,
  dateD :dateD,
  dateF:dateF,
  codeVeh:codeVeh,
  matriculeRem:matriculeRem,
  tLieuChargement:tLieuChargement,
 tLieuDechargement:tLieuDechargement,
 statutMiss:statutMiss,
 codeCl:codeCl,
 typeMissionTransport:typeMissionTransport,
 btNdoc:btNdoc,
 btDateDoc:btDateDoc,
 btNrecu:btNrecu,
 btDateRecu:btDateRecu,


  );
 }
}