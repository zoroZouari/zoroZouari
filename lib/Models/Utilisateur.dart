class Utilisateur {
  final int codeUser;
  final String loginUser;
  final String motPassUser;
  final int codeDroit;
  final String nomUser;
  final String prenomUser;

  Utilisateur({
    required this.codeUser,
    required this.loginUser,
    required this.motPassUser,
    required this.codeDroit,
    required this.nomUser,
    required this.prenomUser,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      codeUser: json['codeUser'] ?? 0,
      loginUser: json['loginUser'] ?? '',
      motPassUser: json['motPassUser'] ?? '',
      codeDroit: json['codeDroit'] ?? 0,
      nomUser: json['nomUser'] ?? '',
      prenomUser: json['prenomUser'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codeUser': codeUser,
      'loginUser': loginUser,
      'motPassUser': motPassUser,
      'codeDroit': codeDroit,
      'nomUser': nomUser,
      'prenomUser': prenomUser,
    };
  }
}
