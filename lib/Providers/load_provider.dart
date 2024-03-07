import 'package:flutter/material.dart';

class LoadProvider extends ChangeNotifier {

  bool _loading = false; 
  //getter y setter para poder aplicar notify 
  bool get loading => _loading; 

  set loading (bool value) {
    _loading = value; 
    notifyListeners(); 
  }

}