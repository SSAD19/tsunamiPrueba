import 'package:flutter/cupertino.dart';
import 'package:tsunami_stef/Models/models.dart';


class CardTextos extends StatelessWidget {
  const CardTextos({super.key, required this.texto});

 final Texts texto; 

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('user.alias'),
          Text('texto.texto'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                //TODO: FUNCIONALIDAD ME GUSTA 

              },
               icon: texto.contador != 0  
               ? Icon(CupertinoIcons.heart)
               : Icon(CupertinoIcons.heart_solid,)),

               Text('texto.contador')
            ],
          )
          
        ],
      ),

    );
  }
}