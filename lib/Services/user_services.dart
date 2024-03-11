import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsunami_stef/Models/models.dart';

class UsersServices with ChangeNotifier {

final String _baseUrl = 'tsunami-app-41226-default-rtdb.firebaseio.com';

List<Usuario> allUsers =[]; 

UsersProvider(){
  //rescatar mail e idUser de todos para poder buscar luego por mail el id
traerOtrosUsuarios();

}

//metodo para recuperar usuarios //funciona 
Future<Usuario> traerUnUsuario ( int id)  async {
  
      final url = Uri.https(_baseUrl,'Usuario/$id.json'); 
      final users = await http.get(url); 
      final userMap = json.decode(users.body); 
      final tempUser = Usuario.fromJson(userMap);

      final user= tempUser; 
      //TODO: BORRAR
      print('${user.alias} y ${user.correo}');

      notifyListeners();
      return user; 
}

Future<void> traerOtrosUsuarios () async {

final url = Uri.https(_baseUrl,'Usuarios.json'); 
final users = await http.get(url);

//según video deberia ser un map<String, dynamic> 
final usersMapeo = json.decode(users.body); 

usersMapeo.forEach((key,value) {
  final tempUser = Usuario.otherfromJson(value);
  tempUser.name = key;
  (tempUser.activo == true) 
  ? allUsers.add(tempUser)
  : null;
});

notifyListeners(); 
// return allUsers; 
}

//put 
//modificar usuarui (int id) 

//post
//alta usuario (id) .-

//delete ¿?
// baja usuario : baja logica


  
}