import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsunami_stef/Models/models.dart';
import 'package:tsunami_stef/Providers/provider.dart';
import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/Theme/themelight.dart';

class NewText extends StatelessWidget {
  const NewText({super.key});

  @override
  Widget build(BuildContext context) {

    final txtProvider = Provider.of<AddTextProv>(context);
    final newtxtProv = Provider.of<TextsServices>(context);
    final userProv = Provider.of<UsersServices>(context);


    return Card( 
      child: AlertDialog(
        shadowColor: Colors.white,
        elevation: 15,
        backgroundColor: Colors.white,
        title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,  
            children: [
            Text('¿Qué estás pensando?', 
            style: TextStyle(fontSize: 14,
            color: ThemeCustomLight.primary,
            ),
            ),
            const Icon ( CupertinoIcons.pencil,
            size: 25),
            ],), 
        content:  const _MiTexto(),
        actions: [
          TextButton(
            child:  Text('Volver', 
            style: TextStyle(color: ThemeCustomLight.primary),),
            onPressed: () {
              txtProvider.txtController.clear();
              txtProvider.dispose(); 
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Postear', 
            style: TextStyle(color: ThemeCustomLight.primary),),
            onPressed: () async {

            if (!txtProvider.validarForm()) return print('error en algún dato'); 

            txtProvider.idUser = userProv.userLog!.idUser!; 
            txtProvider.idTexto  = await newtxtProv.buscarIdMax(); 

            Texts nuevoText = Texts(idTexto: txtProvider.idTexto, idUser: txtProvider.idUser, texto: txtProvider.texto, contador: 0);
            
            await newtxtProv.enviarTexto(nuevoText, userProv.userLog!); 

            Navigator.of(context).pushReplacementNamed('home');
            
            txtProvider.txtController.clear();
            txtProvider.dispose();
            },
          ),
        ],
      ),);
  }
}



class _MiTexto extends StatelessWidget {
  const _MiTexto({
    super.key
  });
 
  @override
  Widget build(BuildContext context) {
    final txtProvider = Provider.of<AddTextProv>(context);

    return SingleChildScrollView(
      child: Form(
            key: txtProvider.addKey,
            autovalidateMode:AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: txtProvider.txtController,
              decoration: const InputDecoration(
               hintText: 'la vida es hermosa',
              ),
              textInputAction:TextInputAction.newline,
              style: TextStyle(
                color: ThemeCustomLight.primary,
                fontSize: 14
              ) ,
               maxLines: 4,
               maxLength: 70,
               autocorrect: true,
               validator: (value) {
                (value != null && value.length > 3)
                ? true
                : 'Escriba algo para poder postear';
               },   
               onChanged: (value){
                txtProvider.texto = value;
                print(txtProvider.texto); 
                },             
            ),
          ),
      );
  }
}