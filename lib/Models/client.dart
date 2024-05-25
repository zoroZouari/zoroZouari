class Client {

 
 final int codeCl;
 final String intituleClient;
 

 Client ({

  
  required this.codeCl,
  required this.intituleClient,
 
  

 });
factory Client.fromJson(Map<String, dynamic> json){
int codeCl = json['codeCl'] ?? '';
String intituleClient = json['intituleClient'] ?? '';


return Client(
  codeCl: codeCl, 
  intituleClient: intituleClient, 
 

  );
  
 }
  @override
 String toString()=>intituleClient;
}