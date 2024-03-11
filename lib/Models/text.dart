import 'dart:convert';
import 'package:tsunami_stef/Models/models.dart';

class Textos {
  
 late int idTexto; 
 final int idUser; 
 late Usuario? user; 
 // asignar el usuario en lògica interfaz
 final String texto; 
 int contador;
 String? name;
 late bool userAct; 


  Textos({
    required this.idTexto, 
    required this.idUser, 
    this.user,
    required this.texto, 
    required this.contador,
    this.name
  });

factory Textos.fromRawJson(String str) => Textos.fromJson(json.decode(str));

String toRawJson() => json.encode(toJson());



factory Textos.fromJson(Map<String, dynamic> json) => Textos(
  idTexto: json["idTexto"],
  idUser: json["idUser"], // que recupero usuario por ID user.TraerUno(json["idUser"])
  texto: json["texto"] ?? 'texto vacío',
  contador: json["contador"] ?? 0,
 // name: json["name"] ?? "",
); 


Map<String, dynamic> toJson() => {
    "idTexto": idTexto,
    "idUser": idUser,
    "texto": texto,
    "contador": contador
};
}


