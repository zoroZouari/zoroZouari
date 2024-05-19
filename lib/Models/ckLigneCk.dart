class CkLigneCk {
  final int codeCk;
  final int codeSs;
  final int codeContenu;
  bool? etatContenu; // Allow modification
  String observation;
  final String executant;

  CkLigneCk({
    required this.codeCk,
    required this.codeSs,
    required this.codeContenu,
    required this.etatContenu,
    required this.observation,
    required this.executant,
  });

  factory CkLigneCk.fromJson(Map<String, dynamic> json) {
    return CkLigneCk(
      codeCk: json['codeCk'] ?? 0,
      codeSs: json['codeSs'] ?? 0,
      codeContenu: json['codeContenu'] ?? 0,
      etatContenu: json['etatContenu'],
      observation: json['observation'] ?? '',
      executant: json['executant'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codeCk': codeCk,
      'codeSs': codeSs,
      'codeContenu': codeContenu,
      'etatContenu': etatContenu,
      'observation': observation,
      'executant': executant,
    };
  }
}
