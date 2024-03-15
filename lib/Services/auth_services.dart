import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class AuthServices with ChangeNotifier{

static const storage = FlutterSecureStorage(); 

Future<String> readToken() async {

    return await storage.read(key: 'token') ?? '';

  }

final authBase= 'identitytoolkit.googleapis.com'; 
final apiKey= 'AIzaSyDmWtDUKvaKxvBU1X56b0vTUHkcpYYBKzo'; 

Future<String?> registrarUser(String email, String password) async{

    final Map<String, dynamic> data ={
      'email': email,
      'password': password,
      'returnSecureToken': true
    }; 

    final url = Uri.https(authBase, 'v1/accounts:signUp', {
      'key': apiKey}); 
   
    final sendData = await http.post(url, body: json.encode(data)); 
    
    final Map<String, dynamic> decodedResp = json.decode(sendData.body);
    
    if (decodedResp.containsKey('idToken')) {
    await storage.write(key: 'token', value: decodedResp['idToken']);
    return null; 
    
     }else {

        if( decodedResp['error']['message'] == 'EMAIL_EXISTS') {
          return 'El email ingresado ya está registrado';

        } else  {

             return 'Error de validación. ${decodedResp['error']['message']}';
        }
    
    }

  }

Future<String?> iniciarSesion(String email, String password) async{

    final Map<String, dynamic> data =
    {
      'email': email,
      'password': password,
      'returnSecureToken': true
    }; 

    final url = Uri.https(authBase, 'v1/accounts:signInWithPassword', {
      'key': apiKey}); 
   
    final sendData = await http.post(url, body: json.encode(data)); 
    final Map<String, dynamic> decodedResp = json.decode(sendData.body);

   if (decodedResp.containsKey('idToken')) {
    await storage.write(key: 'token', value: decodedResp['idToken']);
    return null; 

   }else {

      if( decodedResp['error']['message'] == 'EMAIL_NOT_FOUND') {
          return 'El email ingresado no está registrado';

        } else if(decodedResp['error']['message'] == 'INVALID_PASSWORD'){
          
          return 'Contraseña incorrecta';

        } else  {

             return 'Error de validación. ${decodedResp['error']['message']}';
        }
    
    }

  }

Future<void> logOut () async {
     await storage.delete(key: 'token');
  }


Future<String?> recuperarDatos (String token) async {

  final Map<String, String> data = {
    'idToken' : token   
  };

  final urlBase = Uri.https(authBase, 'v1/accounts:lookup', {'key': apiKey}); 
  final sendData = await http.post(urlBase, body: json.encode(data)); 

  final Map<String, dynamic> getData = json.decode(sendData.body);

    
    if (getData.containsKey('users')) {
      
      final List<dynamic> users = getData['users'];

      if (users.isNotEmpty) {
        final Map<String, dynamic> userData = users[0];

        if (userData.containsKey('email')) {
          return userData['email'];
        }
      }
        }

   if (getData['error']['message'] == 'INVALID_ID_TOKEN') return 'invalido'; 
   if (getData['error']['message'] == 'USER_NOT_FOUND') return 'invalido'; 

   if (sendData.statusCode != 200) return 'invalido'; 


}
  

Future<bool> restablecerContrasenia (String clave) async {

   final token = await readToken(); 

   final Map<String, dynamic> data ={
      'idToken': token,
      'password': clave,
      'returnSecureToken': true
    }; 

    final url = Uri.https(authBase, 'v1/accounts:update', {
      'key': apiKey}); 
   
    final sendData = await http.post(url, body: json.encode(data)); 
    
    final Map<String, dynamic> decodedResp = json.decode(sendData.body);


    if (decodedResp.containsKey('idToken')) {

        await storage.write(key: 'token', value: decodedResp['idToken']);
       
        return true; 
        
     }else {
        print(decodedResp['error']['message']); 
       
        return false; 
    }
 
}
}



