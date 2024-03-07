import 'package:flutter/material.dart';

import 'package:tsunami_final/Providers/provider.dart';

import 'package:lottie/lottie.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
      //provider load 

  final loadProv = Provider.of<LoadProvider>(context); 
  final token = ''; 

  loadProv.loading = true; 

  Future.delayed(const Duration(seconds: 5), () {
    print('entrando al primer delay'); 
    loadProv.loading = false;
  });

  Future.delayed(const Duration(seconds: 5),
         () {
          print('entrando al segundo delay'); 
          (token == '' || token.isEmpty)          
           ? Navigator.pushReplacementNamed(context, 'login')
           : Navigator.pushReplacementNamed(context, 'home');  
        });


    return  Center(
      child: Column(children: [
        const Text('Tsunami'),
        Lottie.asset('assets/wave_load.json')
        
      ]),
    );
  }
}