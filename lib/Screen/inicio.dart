import 'dart:async';

import 'package:flutter/material.dart';

import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/widgets/widgets.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override 
  void initState() {
    super.initState();
    navegar();
  }

  Future<void> navegar() async  {
    
    final authToken = Provider.of<AuthServices>(context, listen: false);
    final userProv = Provider.of<UsersServices>(context, listen: false); 
    final textsProv = Provider.of<TextsServices>(context, listen: false);

      textsProv.textos=[]; 
      await userProv.traerUsuarios(); 
      textsProv.usuarios= userProv.allUsers; 
      await textsProv.traerTextos();

      await Future.delayed(const Duration(seconds: 3));

      var token = await authToken.readToken();

      if (token == '' || token.isEmpty) {

        authToken.logOut();
        Navigator.pushReplacementNamed(context, 'login'); 
        
      } else {
        String email;

        print(token); 

          email = await authToken.recuperarDatos(token) ?? 'invalido'; 

        if (email == 'invalido') {

          authToken.logOut();
           Navigator.pushReplacementNamed(context, 'login'); 

        } else {

          userProv.userLogeado(email);
          Navigator.pushReplacementNamed(context, 'home');
          
        }
       
      } 
    }

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
      body: LoadWave()); 

  }
  
}