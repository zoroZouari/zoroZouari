class LieuChargement {

 
 final int codeLieuCharg;
 final String desigLieuCharg;
 

 LieuChargement ({

  
  required this.codeLieuCharg,
  required this.desigLieuCharg,
   
  

 });
factory LieuChargement.fromJson(Map<String, dynamic> json){
String desigLieuCharg = json['desigLieuCharg'] ?? '';
int codeLieuCharg = json['codeLieuCharg'] ?? '';
 

return LieuChargement(
  desigLieuCharg: desigLieuCharg, 
  codeLieuCharg: codeLieuCharg, 
 

  );
  
 }
 @override
 String toString()=>desigLieuCharg;
 
}