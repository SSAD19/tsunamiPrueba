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

      await Future.delayed(const Duration(seconds: 3));
      var token = await authToken.readToken();
 

      if (token == '' || token.isEmpty) {

        authToken.logOut();
        Navigator.pushReplacementNamed(context, 'login'); 
        
      } else {
        String email;

        print(token); 

       email = await authToken.recuperarDatos(token) ?? 'error'; 

        if (email == 'invalido') {

          authToken.logOut();
           Navigator.pushReplacementNamed(context, 'login'); 

        } else {
           final userProv =  Provider.of<UsersServices>(context, listen: false); 

           userProv.userLogeado(email); 
           print(userProv.userLog?.alias ?? 'sin userLog'); 

          Navigator.pushReplacementNamed(context, 'home');
        }
       
      } 
    }
 

  @override
  Widget build(BuildContext context) {

    final userProv = Provider.of<UsersServices>(context); 
    
    userProv.traerUsuarios(); 
    
     return const Scaffold(
      body: LoadWave()); 

  }
  
}