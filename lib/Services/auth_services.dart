import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class AuthServices with ChangeNotifier{

static final storage = FlutterSecureStorage(); 
// await storage.write(key: 'token', value: decodedResp['idToken']);

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
   
    final sendData = await http.post(url, body: jsonEncode(data)); 
    
    final Map<String, dynamic> decodedResp = json.decode(sendData.body);

    decodedResp.containsKey('idToken')
    ? await storage.write(key: 'token', value: decodedResp['idToken'])
    : decodedResp['error']['message']; 

  }

  Future<String?> iniciarSesion(String email, String password) async{

    final Map<String, dynamic> data ={
      'email': email,
      'password': password,
      'returnSecureToken': true
    }; 

    final url = Uri.https(authBase, 'v1/accounts:signInWithPassword', {
      'key': apiKey}); 
   
    final sendData = await http.post(url, body: jsonEncode(data)); 
    final Map<String, dynamic> decodedResp = json.decode(sendData.body);

    decodedResp.containsKey('idToken')
    ? await storage.write(key: 'token', value: decodedResp['idToken'])
    : decodedResp['error']['message']; 

  }





}