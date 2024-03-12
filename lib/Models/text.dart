import 'dart:convert';
import 'package:tsunami_stef/Models/models.dart';

class Texts {
  
 int idTexto; 
 int idUser; 
 Usuario? user; 
 // asignar el usuario en lògica interfaz
 String texto; 
 int contador;
 String? name;
 bool? userAct; 


  Texts({
    required this.idTexto, 
    required this.idUser, 
    this.user,
    required this.texto, 
    required this.contador,
    this.name,
    this.userAct
  });

factory Texts.fromRawJson(String str) => Texts.fromJson(json.decode(str));
factory Texts.fromJson(Map<String, dynamic> json) => Texts(
  idTexto: json["idTexto"],
  idUser: json["idUser"], // que recupero usuario por ID user.TraerUno(json["idUser"])
  texto: json["texto"] ?? 'texto vacío',
  contador: json["contador"] ?? 0
); 

String toRawJson() => json.encode(toJson());
Map<String, dynamic> toJson() => {
    "idTexto": idTexto,
    "idUser": idUser,
    "texto": texto,
    "contador": contador
};

}


