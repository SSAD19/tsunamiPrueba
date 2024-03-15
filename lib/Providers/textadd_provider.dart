import 'package:flutter/cupertino.dart';

class AddTextProv extends ChangeNotifier {

   GlobalKey<FormState> addKey = GlobalKey<FormState>();
   final  txtController = TextEditingController(); 

   int idUser = -1;
   int idTexto = -1 ;
   String texto = ''; 

AddTextProv(); 

 bool validarForm(){

    notifyListeners(); 
    return addKey.currentState?.validate() ?? false;
  }
  
  void dispose() {

     idUser = -1;
     idTexto = -1 ;
     texto = ''; 
    super.dispose();
    
  }

}