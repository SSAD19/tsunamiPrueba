import 'package:tsunami_stef/Models/models.dart';
import 'package:tsunami_stef/Providers/provider.dart';
import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/Theme/themelight.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final loginProv = Provider.of<LoginProvider>(context); 

    return Scaffold(
      appBar: AppBar(
        leading:const  Icon(Icons.tsunami_outlined),
        title: const Text('Tsunami'), 
      ),
      body:Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 45,), 

              const Center(child: Text('¿Sos nuevo?'),),
              Switch(value: loginProv.switchController, 
              onChanged: (value){
                loginProv.switchController=value; 
                loginProv.limpiarInputs(); 
              }),
              
              const SizedBox(height: 5,),
               _CardContainer(userReg: loginProv.switchController), 

            ],
          ),
        ),
      ) ,
    ), );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({super.key, required this.userReg});
  final bool userReg; 

  @override
  Widget build(BuildContext context) {

    final loginProv = Provider.of<LoginProvider>(context);
    final authProv = Provider.of<AuthServices>(context);
  

    return  Container(
      padding: const EdgeInsets.symmetric( horizontal: 30 ),
      margin: const EdgeInsets.all(20),
      decoration: ThemeCustomLight.decoBox(),
      child: Column(
        children: [
            
          const SizedBox(height: 15,),

          userReg
          ? const Text('Registro de nuevo usuario')
          : const Text('Inicio de sesión'),

          const Divider(),

          userReg
          ? _FormReg(loginProv: loginProv)
          : _FormLog(loginProv: loginProv),

          userReg
           //REGISTRARSE  BOTON 
          ? MaterialButton(
            onPressed: () async {

           if(!loginProv.validarForm()){

             ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(content: Text('Alguno de los datos es incorrecto, por favor, revise.')),        
            );
            return; 
           } else{

              String? error = await  authProv.registrarUser(loginProv.correo!, loginProv.password!); 
       
            if ( error == null ) {
                  
                  Usuario newUser =  Usuario(alias: loginProv.alias! , correo:loginProv.correo!, activo: true); 
                  
                  final userProv = Provider.of<UsersServices>(context, listen: false);

                  bool alta = await userProv.altaUsuario(newUser); 

                  alta ? userProv.userLogeado(loginProv.correo!) : null; 
                  alta ?  Navigator.pushReplacementNamed(context, 'home')
                  :  ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al generar el alta del usuario')),        
                     );
                  
                  loginProv.limpiarInputs(); 
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error)),        
                  );
                }
           }
          
          },
          child: const Text('Registrarse'),)
          //INICIO SESION BOTON 
          :MaterialButton(onPressed: () async {
            if(!loginProv.validarForm()) 
            { 
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Alguno de los datos es incorrecto, por favor, revise.')),);
              return; 
           } 
          
          String? error = await  authProv.iniciarSesion(loginProv.correo!, loginProv.password!); 
       
          if ( error == null ) {
                  //TODO: cargar textos y asignar cual es el user ??

                  final userProv = Provider.of<UsersServices>(context, listen: false);
                  userProv.userLogeado(loginProv.correo!);              
                  Navigator.pushReplacementNamed(context, 'home');
                  loginProv.limpiarInputs(); 
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No se puede ingresar. $error')));   
          }}, 
          child: const Text('Ingresar'),), 
        ],

      ),
    );
  }
}

class _FormLog extends StatelessWidget {
  const _FormLog({
    super.key,
    required this.loginProv,
  });

  final LoginProvider loginProv;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginProv.formKey, 
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          //correo
          TextFormField(
           controller: loginProv.correoCtrl,
           decoration: ThemeCustomLight.inputField(Icons.email_outlined, 'joe@example.com','Correo'),
           keyboardType: TextInputType.emailAddress,
           onChanged: (value) =>  loginProv.correo=value,  
           validator: (value) {   
           String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
           RegExp regExp  = RegExp(pattern);
           return regExp.hasMatch(value ?? '')
              ? null
              : 'Correo incorrecto';
         },
    
          ),
    
          TextFormField(
           controller: loginProv.passCtrl,
           decoration: ThemeCustomLight.inputField(Icons.password_outlined, 'Example-123','Contraseña'),
           obscureText: true,
           onChanged: (value) => loginProv.password=value,  
            validator: (value) {
              return (value!= null && value.length>7)
                ? null
                : 'La clave debe tener mìnimo 8 caracteres'; 
            },
          ),
    
        ],
      ),
    );
  }
}


class _FormReg extends StatelessWidget {
  const _FormReg({
    super.key,
    required this.loginProv,
  });

  final LoginProvider loginProv;

  @override
  Widget build(BuildContext context) {

    return Form(
      key: loginProv.formKey, 
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          //alias
          TextFormField(
          controller: loginProv.aliasCtrl,
          decoration: ThemeCustomLight.inputField(Icons.person_2_outlined, 'Alias-19','Alias'),
          onChanged: (value) => loginProv.alias=value, 
          validator: (value) {
          
          final userProv = Provider.of<UsersServices>(context, listen: false);
          if (userProv.allUsers.any((user) => user.alias == value)) {
                return 'El alias ya está en uso';
          }

          RegExp regExp  = RegExp(r'^[a-zA-Z0-9._-]+$');

          return (regExp.hasMatch(value!) || value.length > 3) ? null  : 'Alias incorrecto';

          },),
          //correo
          TextFormField(
           controller: loginProv.correoCtrl,
           decoration: ThemeCustomLight.inputField(Icons.email_outlined, 'joe@example.com','Correo'),
           keyboardType: TextInputType.emailAddress,
           onChanged: (value) =>  loginProv.correo=value,  
           validator: (value) {   
           RegExp regExp  = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
           return regExp.hasMatch(value ?? '')  ? null  : 'Correo incorrecto';
         },
    
          ),
    
          TextFormField(
           controller: loginProv.passCtrl,
           decoration: ThemeCustomLight.inputField(Icons.password_outlined, 'Example-123','Contraseña'),
           obscureText: true,
           onChanged: (value) => loginProv.password=value,  
           validator: (value) {
             return (value!= null && value.length>7) ? null : 'La clave debe tener mìnimo 8 caracteres'; 
            },
          ),
      
          TextFormField(
          controller: loginProv.pass2Ctrl,
          decoration: ThemeCustomLight.inputField(Icons.password, 'Example-123','Repetir contraseña'),
          obscureText: true, 
          validator: (value) {
            loginProv.password == value ? null : 'No coinciden las contraseñas'; 
          },       
     
        )
        ],
      ),
    );
  }
}