import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadWave extends StatelessWidget {
  const LoadWave({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
    child: Container(
    padding: const EdgeInsets.all(5),
      width: double.infinity,  
          child: 
            Lottie.asset('assets/wave_load.json'),
          
      ),
  );
  }
}