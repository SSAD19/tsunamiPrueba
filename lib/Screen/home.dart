import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsunami_stef/Pages/pages.dart';
import 'package:tsunami_stef/Providers/provider.dart';
import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/Theme/themelight.dart';
import 'package:tsunami_stef/widgets/widgets.dart';





class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); 
    final page = Provider.of<LoadProvider>(context); 

    final userProv = Provider.of<UsersServices>(context); 
    final textProv = Provider.of<TextsServices>(context); 

    textProv.textUserLog(userProv.userLog!.idUser!);
   
    return  SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu, size: 40,),
            onPressed: (){
             scaffoldKey.currentState!.openDrawer();
            },
          )
         ,
          title: const  Text('Tsunami', style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          actions: const [
             Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.tsunami,
              size: 40,),
            )
          ],
        ),
        drawer:  Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children:  [
               DrawerHeader(
                decoration:  BoxDecoration(
                  color:  ThemeCustomLight.primary,
                ), 
                child:Padding(
                      padding:const EdgeInsets.only(top:80),                     
                        child: Text(userProv.userLog!.alias, 
                        textAlign: TextAlign.center,
                        style: const  TextStyle(
                            color: Colors.white,
                            fontSize: 24                    
                        ),),
                      ),
                ),
                 
              
              ListTile(
                leading: const Icon(Icons.home),
                title:const Text('Home'),
                 onTap: () {
                  page.pagina = const HomePage();                  
                  Navigator.pop(context);
                 }
              ),
               ListTile(
                leading: const Icon(Icons.people),
                title:const Text('Mis Textos'),
                 onTap: () {
                  page.pagina = const UserTextPage();                  
                  Navigator.pop(context);
                 }
              ),
              ListTile( 
                leading: const Icon(Icons.settings),
                title:const Text('Perfil'),
               onTap: () {
                  page.pagina =   PerfilPages(userLog: userProv);                  
                  Navigator.pop(context);
                 }
                ),
              ListTile( 
                leading: const Icon(Icons.exit_to_app),
                title:const Text('Cerrar Sesión '),
                onTap: () {
                  final authProv = Provider.of<AuthServices>(context, listen:false); 
                  authProv.logOut(); 
                  textProv.textos = []; 
                  Navigator.pushReplacementNamed(context, 'inicio');
                  page.pagina = const HomePage(); 
                  
                  },
                 ),
          ]),
          
        ),
      
        body: Container(
          child: page.pagina,
        ),
        
        floatingActionButtonLocation:  FloatingActionButtonLocation.endContained,
        floatingActionButton: const AddText(),),
    );
  }
}
class AddText extends StatelessWidget {
  const AddText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
                          onPressed: (){
          //llamar alertDialog para postear texto nuevo  
          _showMyDialog(context);
      
        },
        elevation: 10,
        splashColor: const Color.fromARGB(225, 113, 232, 245),
        backgroundColor: ThemeCustomLight.primary,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70), 
          ),
        child:const Stack(
            children: [Icon(Icons.tsunami, 
            size: 40),
            Positioned(
              top:-3,
              right: -3,
              child: Icon(CupertinoIcons.add,
              size:15),),
            ],
          ),
        );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 

    builder: (BuildContext context) {

      return const NewText();
    },
  );
}