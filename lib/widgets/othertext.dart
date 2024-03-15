import 'package:flutter/material.dart';
import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/widgets/widgets.dart';

import '../Theme/themelight.dart';


class OthersTexts extends StatelessWidget {
  const OthersTexts({
    super.key, required this.textos,
  });
  
 final TextsServices textos;  

  @override
  Widget build(BuildContext context) {

    final textos_ = textos.textos.where((e) => e.userAct == false).toList();  

    return textos_.isNotEmpty
    ? ListView.separated(
      //TODO: revisar de  traer una cantidad e ir sumando los mas nuevos
      shrinkWrap: true,
      itemCount:textos_.length, 
      separatorBuilder: (BuildContext context, int i) {
        return  Divider(color: ThemeCustomLight.primary,);
      },
      itemBuilder: (BuildContext context, int i) {
        return CardTextos(  texto: textos_[i], userAct: false, );
      },
    )
    : const Center(child: Text('Sin posteos para mostrar', 
    style: TextStyle(
      fontSize: 26
    ),));
  }
}
