import 'dart:convert';

class Usuario{

 final bool activo;
 final String alias;
 final int idUser;
 final String correo;
 late String name; 

//solo me interesa alias, id y que este activo para los textos

Usuario({
  required this.activo,
  required this.alias,
  required this.idUser,
  required this.correo, 
});

   factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));


    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        activo: json["activo"],
        alias: json["alias"],
        idUser: json["idUser"],
        correo: json["correo"],
    );



factory Usuario.otherfromRawJson(String str) => Usuario.otherfromJson(json.decode(str));

    factory Usuario.otherfromJson(Map<String, dynamic> json) => Usuario(
        activo: json["activo"],
        alias: json["alias"],
        idUser: json["idUser"],
        correo: json["correo"],
    );


//se va ausar solo al  registrar  o modificar usuario
Map<String, dynamic> toJson() => {
        "activo": activo,
        "alias": alias,
        "idUser": idUser,
        "correo": correo,
};

}