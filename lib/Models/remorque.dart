class Remorque {
 final String matriculeRem;

 Remorque ({
  required this.matriculeRem,

 });
factory Remorque.fromJson(Map<String, dynamic> json){
String MatriculeRem = json['matriculeRem'] ?? '';

return Remorque(
  matriculeRem: MatriculeRem, 
  );
 }
}