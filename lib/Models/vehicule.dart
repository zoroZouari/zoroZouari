

class Vehicule {
        final String immatriculationVeh ;
       

        Vehicule({
          required this.immatriculationVeh,
        });

        factory Vehicule.fromJson(Map<String, dynamic> json){
          String immatriculationVeh = json['immatriculationVeh'] ?? '';

          return Vehicule(
            immatriculationVeh: immatriculationVeh,
          );
        }
    }

  
