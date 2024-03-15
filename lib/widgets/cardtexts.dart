import 'package:flutter/cupertino.dart';
import 'package:tsunami_stef/Models/models.dart';


class CardTextos extends StatelessWidget {
  const CardTextos({super.key, required this.texto, required this.userAct});

 final Texts texto; 
 final bool userAct; 
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(texto.user!.alias),
          Text(texto.texto),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                //TODO: FUNCIONALIDAD ME GUSTA 
              },
               icon: texto.contador != 0  
               ? Icon(CupertinoIcons.heart_solid)
               : Icon(CupertinoIcons.heart,)),

               Text('${texto.contador}'),

               userAct 
               ? TextButton(
                  onPressed: () {
                  // TODO : BORRAR

                  },  
                  child:const  Text('borrar'))
               : const SizedBox(height: 1,), 
            ],
          )
          
        ],
      ),

    );
  }
}