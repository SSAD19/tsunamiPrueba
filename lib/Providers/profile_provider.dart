import 'package:tsunami_stef/Models/models.dart';

class ProfileProvider with ChangeNotifier {

  bool _ocultarClave = true ; 

 bool get ocultarClave => _ocultarClave; 

  set ocultarClave (bool value) {

    _ocultarClave= value; 
    notifyListeners(); 
  }


}