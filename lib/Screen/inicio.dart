import 'dart:async';

import 'package:flutter/material.dart';

import 'package:tsunami_stef/Providers/provider.dart';
import 'package:tsunami_stef/Services/auth_services.dart';
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
      print('entrando al delay'); 
      final authToken = Provider.of<AuthServices>(context, listen: false);

      await Future.delayed(const Duration(seconds: 7));
      var token = await authToken.readToken();
      print(token); 
      (token == '' || token.isEmpty)
          ? Navigator.pushReplacementNamed(context, 'login')
          : Navigator.pushReplacementNamed(context, 'home'); 
     }
 

  @override
  Widget build(BuildContext context) {
        
     return const Scaffold(
      body: LoadWave()); 

  }
  
}