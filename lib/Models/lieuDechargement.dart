class LieuDechargement {

 
 final int codeLieudeCharg;
 final String desigLieudeCharg;
 

 LieuDechargement ({

  
  required this.codeLieudeCharg,
  required this.desigLieudeCharg,
   
  

 });
factory LieuDechargement.fromJson(Map<String, dynamic> json){
String desigLieudeCharg = json['desigLieudeCharg'] ?? '';
int codeLieudeCharg = json['codeLieudeCharg'] ?? '';
 

return LieuDechargement(
  desigLieudeCharg: desigLieudeCharg, 
  codeLieudeCharg: codeLieudeCharg, 
 

  );
  
 }
 @override
 String toString()=>desigLieudeCharg;
 
}