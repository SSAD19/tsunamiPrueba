import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsunami_stef/Models/models.dart';

class UsersServices with ChangeNotifier {

final String _baseUrl = 'tsunami-app-41226-default-rtdb.firebaseio.com';

List<Usuario> allUsers =[]; 

UsersProvider(){
  //rescatar mail e idUser de todos para poder buscar luego por mail el id
traerUsuarios();
}

Future<void> traerUsuarios () async {
  try {

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
    
  }  catch (e) {
      print(e); 
  }
}

void userLogeado (String correo) {
//TODO: buscar en mi listado el que contenga el correo 
}



//put 
//modificar usuarui (int id) 

//post
//alta usuario (id) .-
Future<bool> altaUsuario (Usuario user) async {

  try{
    allUsers.isNotEmpty 
    ? user.idUser = (allUsers.map((user) => user.idUser).reduce((a, b) => a > b ? a : b))+1
    : user.idUser = 0; 

    user.activo = true; 
    final url = Uri.https(_baseUrl,'Usuarios.json'); 
    await http.post(url, body:jsonEncode(user.toJson()));

    return true; 

  } catch (e) {
    return false; 
  }
}

//delete ¿?
// baja usuario : baja logica


  
}