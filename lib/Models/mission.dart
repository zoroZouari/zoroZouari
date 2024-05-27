class Mission {
  final int codeMiss;
  final DateTime dateD;
  final DateTime dateF;
  final String codeChauff;
  final String codeVeh;
  final String matriculeRem;
  final int tLieuChargement;
  final int tLieuDechargement;
  final int statutMiss;
  final int tCodeCl;
  final String typeMissionTransport;
  final String btNdoc;
  final DateTime btDateDoc;
  final String btNrecu;
  final DateTime btDateRecu;
  final String information;
  final String depart;
  final String arriver;
  final String lieu;
  final int codeReg;
  Mission({
    required this.codeMiss,
    required this.dateD,
    required this.dateF,
    required this.codeChauff,
    required this.codeVeh,
    required this.matriculeRem,
    required this.tLieuChargement,
    required this.tLieuDechargement,
    required this.statutMiss,
    required this.tCodeCl,
    required this.typeMissionTransport,
    required this.btNdoc,
    required this.btDateDoc,
    required this.btNrecu,
    required this.btDateRecu,
    required this.lieu,
    required this.information,
    required this.depart,
    required this.arriver,
    required this.codeReg,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      codeMiss: json['codeMiss'] ?? 0,
      dateD: json['dateD'] != null ? DateTime.parse(json['dateD']) : DateTime.now(),
      dateF: json['dateF'] != null ? DateTime.parse(json['dateF']) : DateTime.now(),
      codeChauff: json['codeChauff'] ?? '',
      codeVeh: json['codeVeh'] ?? '',
      matriculeRem: json['matriculeRem'] ?? '',
      tLieuChargement: json['tLieuChargement'] ?? 0,
      tLieuDechargement: json['tLieuDechargement'] ?? 0,
      statutMiss: json['statutMiss'] ?? 0,
      tCodeCl: json['tCodeCl'] ?? 0,
      typeMissionTransport: json['typeMissionTransport'] ?? '',
      btNdoc: json['btNdoc'] ?? '',
      btDateDoc: json['btDateDoc'] != null ? DateTime.parse(json['btDateDoc']) : DateTime.now(),
      btNrecu: json['btNrecu'] ?? '',
      btDateRecu: json['btDateRecu'] != null ? DateTime.parse(json['btDateRecu']) : DateTime.now(),
      depart: json['depart'] ?? '',
      arriver: json['arriver'] ?? '',
      information: json['information'] ?? '',
      lieu: json['lieu'] ?? '',
      codeReg: json['codeReg'] ?? '',
      

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codeMiss': codeMiss,
      'dateD': dateD.toIso8601String(),
      'dateF': dateF.toIso8601String(),
      'codeChauff': codeChauff,
      'codeVeh': codeVeh,
      'matriculeRem': matriculeRem,
      'tLieuChargement': tLieuChargement,
      'tLieuDechargement': tLieuDechargement,
      'statutMiss': statutMiss,
      'tCodeCl': tCodeCl,
      'typeMissionTransport': typeMissionTransport,
      'btNdoc': btNdoc,
      'btDateDoc': btDateDoc.toIso8601String(),
      'btNrecu': btNrecu,
      'btDateRecu': btDateRecu.toIso8601String(),
      'depart': depart,
      'arriver': arriver,
      'lieu': lieu,
      'information': information,
      'codeReg': codeReg,
    };
  }
}
