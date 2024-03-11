import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:tsunami_stef/Models/models.dart';

class TextServices with ChangeNotifier {

  final String _baseUrl = 'tsunami-app-41226-default-rtdb.firebaseio.com';

  List<Textos> textos =[]; 
  List<Usuario> usuarios =[]; 
 

  TextServices(); 

Future recuperarTodos (int id) async {
      await traerTextos(id); 
      await aliasTextos(); 
      notifyListeners(); 

}

void limpiarTextos(){
 textos=[]; 
}

Future<void> traerTextos (int id)  async {

    print('entrando a recuperar');  
    final url = Uri.https(_baseUrl,'Textos.json'); 
    final texts = await http.get(url);

    //según video deberia ser un map<String, dynamic> 
    final textsMapeo = json.decode(texts.body); 
    textsMapeo.forEach((key, value) { 
      
      final textMap = Textos.fromJson(value);
        textMap.name = key; 
        textMap.idUser != id
        ? textMap.userAct= false
        : textMap.userAct= true;

        textos.add(textMap);
    });

}

// para llenar los usuarios 
Future aliasTextos() async {
print('entrando en ciclo alias');

    if (usuarios.isNotEmpty) {
      for (final texto in textos) {
        for (final usuario in usuarios) {
          if (texto.idUser == usuario.idUser) {
            texto.user = usuario;
          }
        }
      }

   print('saliendo en cicloa alias'); 
}

 
Future<void> enviarTexto(Textos texto) async {

    final url = Uri.https(_baseUrl, 'Textos.json');
    try {
      await http.post(url, body: json.encode(texto.toJson()),);

    } catch (e) {
      print('Se produjo un error. $e');
    }
  }

//asignar maxID 
  Future<int> BuscarIdMax () async {
    
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
      print(maxIdTexto);
      return maxIdTexto + 1;

    } else {
      print('No se pudo obtener el ID máximo.');
      return -1;
    }
    
  }
     
     
  // actualizar solo textosUsers 

     
    //TODO: Delete del idTexto seleccionado
Future<void> borrarTexto (String name, int id) async {

    print('entrando a borrar');  
    final url = Uri.https(_baseUrl,'Textos/${name}.json'); 
    await http.delete(url);
    recuperarTodos(id); 

}

// put para actualizar contador  


Future<void> masUnoCont (Textos texto) async{
    
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
}