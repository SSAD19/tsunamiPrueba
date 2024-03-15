
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tsunami_stef/Models/models.dart';

import 'package:tsunami_stef/Providers/provider.dart';
import 'package:tsunami_stef/Services/services.dart';


class PerfilPages extends StatelessWidget {
  PerfilPages({
    super.key, 
    required this.userLog});
  
  UsersServices userLog; 

  @override
  Widget build(BuildContext context) {
   
    final profileProv = Provider.of<ProfileProvider>(context); 

   return   Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: profileProv.claveKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              const Icon(Icons.people_sharp, size: 40,),   
                              const SizedBox(width: 15,),  
                              Text( userLog.userLog!.alias.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle( 
                                fontSize: 30,

                              ), ),
                              
                              ]
                            ),
                            const Divider(), 
                            const SizedBox(height: 15,),

                            TextFormField( 
                              initialValue: userLog.userLog!.correo,
                              readOnly: true,
                              decoration: const InputDecoration(
                                label: Text('Correo'),
                                suffixIcon: Icon(CupertinoIcons.mail) 
                              )
                            ),
                      
                            TextFormField( 
                              obscureText: profileProv.ocultarClave,
                              decoration:  InputDecoration(
                                hintText: '******',
                                label: const Text('Cambiar contraseña'),
                                suffixIcon:  IconButton(
                                  icon: profileProv.ocultarClave 
                                  ? const Icon(CupertinoIcons.eye_slash)
                                  : const Icon(CupertinoIcons.eye),
                                  onPressed: () {
                                        profileProv.ocultarClave
                                        ? profileProv.ocultarClave = false
                                        : profileProv.ocultarClave= true;
                                  }),
                                ),
                                onChanged: ((value) =>profileProv.clave =value) ,
                                 validator: (value) {
                                  return (value!= null && value.length>7)
                                    ? null
                                    : 'La clave debe tener mìnimo 8 caracteres'; 
                                },
                            ),

                            //repetir contraseña:
                            TextFormField( 
                              obscureText: profileProv.ocultarClave,
                              decoration:  InputDecoration(
                                hintText: '******',
                                label: const Text('Cambiar contraseña'),
                                suffixIcon:  IconButton(
                                  icon: profileProv.ocultarClave 
                                  ? const Icon(CupertinoIcons.eye_slash)
                                  : const Icon(CupertinoIcons.eye),
                                  onPressed: () {
                                        profileProv.ocultarClave
                                        ? profileProv.ocultarClave = false
                                        : profileProv.ocultarClave= true;
                                  }),
                                ),
                                validator: (value) {
                                   value == profileProv.clave
                                   ? null
                                   :  'No coinciden las contraseñas';
                                   }    
                            ),

                            const SizedBox(height: 15,),
                            TextButton(onPressed: () async {
                              // validaciones 
                             if (!profileProv.validarForm()) return; 

                             //TODO:  PUT DE MI  USER EN AUTH
                              final authProv = Provider.of<AuthServices>(context, listen: false); 
                              final restablecer = await authProv.restablecerContrasenia(profileProv.clave); 

                              restablecer
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Contraseña reestablecida')))
                              :    ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('No se pudo reestablecer la contraseña')));
                            }, 
                            child: Text('Guardar'))
                          ],
                        ),
                      ),
                    ),
                ),
          
              ],
   ),
   );
}
}