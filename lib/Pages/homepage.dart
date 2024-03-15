import 'package:flutter/material.dart';

import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/widgets/widgets.dart';

import '../Theme/themelight.dart';

class HomePage
 extends StatelessWidget {
  const HomePage
  ({super.key});
  @override
  Widget build(BuildContext context) { 
 
    final textsProvider = Provider.of<TextsServices>(context); //que carguen al inicializar  

   

    return  SingleChildScrollView(
      child: Padding(
            padding:const  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
              const Busqueda(), 
              const  SizedBox(height: 20,),
            
              OthersTexts(textos: textsProvider,),

              const SizedBox( height: 15,),

              const Text('Mis textos'),
              const SizedBox(height:10),
              
              //cardSWIPER 
               const UserTexts(),
               Divider(color: ThemeCustomLight.primary,),
              ]
            ),
         ),
         
    );
  }
}

//TODO: Funcionalidad de la busqueda 
class Busqueda extends StatelessWidget {
  const Busqueda({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search), 
        hintText: 'vida fit', 
        labelText:'¿De qué tema quieres leer?', 
       labelStyle: const TextStyle(
        color: Colors.white,
       ),
        enabledBorder:  OutlineInputBorder( 
        borderRadius:const  BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
        color:ThemeCustomLight.primary,
        width: 1,),
        ),  
        focusedBorder:  const OutlineInputBorder( 
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            color:Colors.white,
            width: 3,),
        ),
      ),
        
      onChanged: ((value) => value),
      //en el onchanged hacer un debouncer y stream para  buscar los textos
    );
    }
    
  }

