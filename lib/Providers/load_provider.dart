import 'package:flutter/material.dart';
import 'package:tsunami_stef/Models/models.dart';
import 'package:tsunami_stef/Pages/pages.dart';

class LoadProvider with ChangeNotifier {

  bool _loading = false; 
  bool get loading => _loading; 

  set loading (bool value) {
    _loading = value; 
    notifyListeners(); 
  }

  // DRAWER MENU
  
 Widget _pagina = const HomePage(); 

 Widget get pagina => _pagina; 

set pagina (Widget wid) {
_pagina = wid; 
notifyListeners(); 

}

}