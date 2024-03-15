import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tsunami_stef/Models/models.dart';
import 'package:tsunami_stef/Models/models.dart';

class TextsServices with ChangeNotifier {

//TODO: REHACER LOGICA Y PETICIONES DE TEXTOS


  final String _baseUrl = 'tsunami-app-41226-default-rtdb.firebaseio.com';

  List<Texts> textos =[]; 
  List<Usuario> usuarios = []; 

  TextsServices() ;

Future<bool> traerTextos ()  async {

try { 

    final url = Uri.https(_baseUrl,'Textos.json'); 
    final texts = await http.get(url);

    //según video deberia ser un map<String, dynamic> 
    final textsMapeo = json.decode(texts.body); 
    textsMapeo.forEach((key, value) { 
      
      final textMap = Texts.fromJson(value);
        textMap.name = key; 
        textMap.userAct = false;
        textos.add(textMap);
    });

    asignarAlias();
    return true; 

     } catch (e) {

      print(e);
      return false; 
     }
  

}

// para llenar los usuarios 
asignarAlias() {

    if (usuarios.isNotEmpty) {
      for (final texto in textos) {
        for (final usuario in usuarios) {
          if (texto.idUser == usuario.idUser) {
            texto.user = usuario;
          }
        }
      }
}

}


//errpr acà, está trayendo  4 
textUserLog(int id) {

   
 for (int i = 0; i<textos.length; i++){
    if(textos[i].idUser == id){
      textos[i].userAct = true;
  } 
 }

}


//SIN CORREGIR - APLICAR 
 
Future<void> enviarTexto(Texts texto, Usuario user) async {


    final url = Uri.https(_baseUrl, 'Textos.json');
    try {
      await http.post(url, body: json.encode(texto.toJson()),);

      texto.userAct = true; 
      texto.user = user; 
      textos.add(texto);

      notifyListeners(); 

    } catch (e) {
      print('Se produjo un error. $e');
    }
  }

//asignar maxID 
  Future<int> buscarIdMax () async {
    
    int maxIdTexto =0 ; 
    final url = Uri.https(_baseUrl, 'Textos.json');
    
    final idHttp = await http.get(url); 

    final idMap = json.decode(idHttp.body); 
    
    if (idMap != null && idMap.isNotEmpty) {
      idMap.forEach((key, value) {
        int idTexto = value['idTexto'];
        if (idTexto > maxIdTexto) {
          maxIdTexto = idTexto;
        }
      });
      return maxIdTexto + 1;

    } else {
      return -1;
    }
    
  }
     

Future<void> borrarTexto (String name, int id) async {

    print('entrando a borrar');  
    final url = Uri.https(_baseUrl,'Textos/${name}.json'); 
    await http.delete(url);

    textos.removeWhere((element)=>  element.name == name); 
    notifyListeners(); 
}


Future<void> masUnoCont (Texts texto) async{
    
    texto.contador++; 

    print('entrando a borrar');  
    final url = Uri.https(_baseUrl,'Textos/${texto.name}.json');
    await http.put(url, body: json.encode(texto.toJson()));
    //buscar 

    final act = textos.indexWhere((element) => element.idTexto == texto.idTexto );
    textos[act].contador = texto.contador;

    notifyListeners(); 
}
} 