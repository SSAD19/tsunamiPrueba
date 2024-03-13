
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tsunami_stef/Providers/provider.dart';
import 'package:tsunami_stef/Services/services.dart';

class PerfilPages extends StatelessWidget {
  const PerfilPages({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UsersServices>(context); 
    final userLog = userProv.userLog;

    final profileProv = Provider.of<ProfileProvider>(context); 

   return Card(
      child: Form(
        child: Column(
          children: [
            TextFormField( 
              initialValue: userLog!.alias,
              
            ),

             TextFormField( 
              initialValue: userLog.correo,
              readOnly: true,
              decoration: const InputDecoration(
                 label: Text('Correo'),
                 icon: Icon(CupertinoIcons.mail) 
              )
            ),

             TextFormField( 
              obscureText: profileProv.ocultarClave,
              decoration:  InputDecoration(
                 hintText: '******',
                 label: const Text('Contraseña'),
                 suffixIcon: IconButton(
                  icon: profileProv.ocultarClave 
                  ? const Icon(CupertinoIcons.eye_slash)
                  : const Icon(CupertinoIcons.eye),
                  onPressed: () {
                        profileProv.ocultarClave
                        ? profileProv.ocultarClave = false
                        : profileProv.ocultarClave= true;
                   }),
                ),
            ),
          ],
        ),
      ),
    );
}
}