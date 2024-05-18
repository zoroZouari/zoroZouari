class CkLigneCk{
  
  final int codeCk;
  final int codeSs;
  final int codeContenu;
  final bool? etatContenu;
  final String observation;
  final String executant;

  CkLigneCk({
    
    required this.codeCk,
    required this.codeSs,
    required this.codeContenu,
    required this.etatContenu,
    required this.observation,
    required this.executant,
    

  });

  factory CkLigneCk.fromJson(Map<String, dynamic> json){
int codeCk = json['codeCk'] ?? '';
int codeSs = json['codeSs'] ?? '';
int codeContenu = json['codeContenu'] ?? '';
bool etatContenu = json['etatContenu'] as bool;
String observation = json['observation'] ?? '';
String executant = json['executant'] ?? '';


return CkLigneCk(
  codeCk: codeCk, 
  codeSs: codeSs, 
  codeContenu: codeContenu,
  etatContenu: etatContenu,
  observation: observation,
  executant: executant,
  

  );
 }
}