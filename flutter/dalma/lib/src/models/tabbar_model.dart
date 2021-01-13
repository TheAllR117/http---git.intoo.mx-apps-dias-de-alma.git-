import 'dart:convert';

Idioma idiomaFromJson(String str) => Idioma.fromJson(json.decode(str));

String idiomaToJson(Idioma data) => json.encode(data.toJson());

class Idioma {
  Idioma({
    this.espanol,
  });

  Espanol espanol;

  factory Idioma.fromJson(Map<String, dynamic> json) => Idioma(
        espanol: Espanol.fromJson(json["espanol"]),
      );

  Map<String, dynamic> toJson() => {
        "espanol": espanol.toJson(),
      };
}

class Espanol {
  Espanol({
    this.calcular,
    this.inicio,
    this.salir,
    this.ajustes,
  });

  String calcular;
  String inicio;
  String salir;
  String ajustes;

  factory Espanol.fromJson(Map<String, dynamic> json) => Espanol(
        calcular: json["Calcular"],
        inicio: json["Inicio"],
        salir: json["Salir"],
        ajustes: json["Ajustes"],
      );

  Map<String, dynamic> toJson() => {
        "Calcular": calcular,
        "Inicio": inicio,
        "Salir": salir,
        "Ajustes": ajustes,
      };
}
