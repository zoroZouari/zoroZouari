class CkEnteteFiche {
  
  final int codeT;
  final int codeType;
  final int version;

  CkEnteteFiche({
    
    required this.codeT,
    required this.codeType,
    
    required this.version,
  });

  factory CkEnteteFiche.fromJson(Map<String, dynamic> json){
int version = json['version'] ?? '';
int codeT = json['codeT'] ?? '';
int codeType = json['codeType'] ?? '';

return CkEnteteFiche(
  version: version, 
  codeT: codeT, 
  codeType: codeType,

  );
 }
 @override
String toString() => version.toString();

}