import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  
  bool _switchController = false; 
  bool get switchController => _switchController; 

  set switchController (bool value){
    _switchController= value; 
    notifyListeners();
  }

  String? correo; 
  String? password; 
  String? alias; 
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //validacion
  bool validarForm(){
    notifyListeners(); 
    return formKey.currentState?.validate() ?? false;
  }

  TextEditingController correoCtrl = TextEditingController(); 
  TextEditingController passCtrl = TextEditingController();
  TextEditingController pass2Ctrl = TextEditingController();
  TextEditingController aliasCtrl = TextEditingController();

  void limpiarInputs() {
    correoCtrl.clear();
    passCtrl.clear(); 
    pass2Ctrl.clear();
    aliasCtrl.clear();
  }


}