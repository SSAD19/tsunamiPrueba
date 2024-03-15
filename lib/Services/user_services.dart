import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tsunami_stef/Models/models.dart';

class UsersServices with ChangeNotifier {

final String _baseUrl = 'tsunami-app-41226-default-rtdb.firebaseio.com';

List<Usuario> allUsers =[]; 
Usuario? userLog; 

UsersProvider()async {
  //rescatar mail e idUser de todos para poder buscar luego por mail el id
 await traerUsuarios();
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

bool userLogeado (String correoUser) {
try{
  userLog = (allUsers.firstWhere((user) => user.correo == correoUser));
  notifyListeners(); 
  
  return true;

} catch (e) {

  print('ERROR PARA ASGINAR USERlOG: $e'); 
  return false; 
}
 
}

//post
//alta usuario (id) .-
Future<bool> altaUsuario (Usuario user) async {

  try{
    int maxId = 0;

   if (allUsers.isNotEmpty ) {
       for (int i = 0; i<allUsers.length; i++){
       allUsers[i].idUser! > maxId ? maxId = allUsers[i].idUser! : null;   
      }
      user.idUser = maxId +1; 

    } else {
      user.idUser = 0; 
    }
   
    
    user.activo = true; 
    final url = Uri.https(_baseUrl,'Usuarios.json'); 
    await http.post(url, body:jsonEncode(user.toJson()));

    allUsers.add(user); 

    return true; 

  } catch (e) {
    return false; 
  }
}

//delete ¿?
// baja usuario : baja logica


//put 
//modificar usuarui (int id) 

  
}