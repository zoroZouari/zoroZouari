class FaLieuDistance {
  
  final int codeLieuDepart;
  final int codeLieuArrive;
  final int kmDistance;
  final int codeDistance;
  FaLieuDistance({
    
    required this.codeLieuDepart,
    required this.codeLieuArrive,
    required this.kmDistance,
    required this.codeDistance,
  });

  factory FaLieuDistance.fromJson(Map<String, dynamic> json){
int codeLieuDepart = json['codeLieuDepart'] ?? '';
int codeLieuArrive = json['codeLieuArrive'] ?? '';
int kmDistance = json['kmDistance'] ?? '';
int codeDistance = json['codeDistance'] ?? '';

return FaLieuDistance(
  kmDistance: kmDistance, 
  codeLieuDepart: codeLieuDepart, 
  codeLieuArrive: codeLieuArrive,
  codeDistance: codeDistance,

  );
 }
 @override
String toString() => codeDistance.toString();

}