import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:tsunami_stef/Models/models.dart';
import 'package:tsunami_stef/Services/texts_services.dart';
import 'package:tsunami_stef/widgets/widgets.dart';

import '../Providers/provider.dart';


 class UserTexts extends StatelessWidget {
  const UserTexts  ({super.key});

  @override
  Widget build(BuildContext context) { 
  
  SwiperController swipperController = SwiperController();

  final size = MediaQuery.of(context).size;
  
  final textProvider = Provider.of<TextsServices>(context);
  
  final textos = textProvider.textos.where((e) => e.userAct == true).toList();  
  
    return  textos.isNotEmpty
    ? Swiper(
                controller: swipperController,
                itemWidth: size.width * 0.9,
                itemHeight: 150,
                itemCount: textos.length, // textsProvider.userTextos.length, 
                layout: SwiperLayout.STACK,
                itemBuilder:(context, int i) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      child: CardTextos(texto: textos[i], userAct: true,)),
                  );
                },
              )
    : const Center(child: Text('Sin posteos para mostrar', 
    style: TextStyle(
      fontSize: 26
    ),));
  }
}

