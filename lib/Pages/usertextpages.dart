import 'package:flutter/material.dart';
import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/Theme/themelight.dart';
import 'package:tsunami_stef/widgets/widgets.dart';

class UserTextPage
 extends StatelessWidget {
  const UserTextPage
  ({super.key});

  @override
  Widget build(BuildContext context) {

    final textProv = Provider.of<TextsServices>(context);

    final textos = textProv.textos.where((e) => e.userAct == true).toList();  


   return  SingleChildScrollView(
      child: Padding(
            padding:const  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child:  textos.isNotEmpty
            ? Expanded(
              child: ListView.separated(
                //TODO: revisar de  traer una cantidad e ir sumando los mas nuevos
              
                shrinkWrap: true,
                itemCount:textos.length, 
                separatorBuilder: (BuildContext context, int i) {
                  return  Divider(color: ThemeCustomLight.primary,);
                },
                itemBuilder: (BuildContext context, int i) {
                  return CardTextos(  texto: textos[i], userAct: true, );
                },
              ),
            )
            : const Center(child: Text('Sin posteos para mostrar', 
            style: TextStyle(
              fontSize: 26
          ),
        ),
      ),
    ), 
   );
  }
}
