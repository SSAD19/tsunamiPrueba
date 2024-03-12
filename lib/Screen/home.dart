import 'package:flutter/material.dart';
import 'package:tsunami_stef/Services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {


    final userProv = Provider.of<UsersServices>(context);

    print(userProv.userLog?.alias ?? 'sin data'); 


    return Scaffold(
      appBar: AppBar(
        title: const Text('Tsunami'),        
      ),
      body: Padding(
      padding: const EdgeInsets.all(10),
        child: Column(children: [

          const SizedBox(height: 20,),
          const Text('HomeScreen'), 
        
          IconButton(
            onPressed: (){
            final authProv = Provider.of<AuthServices>(context, listen:false); 
            authProv.logOut(); 
            //blanquear userLog
            Navigator.pushReplacementNamed(context, 'inicio');
          }, 
          icon: const Icon(Icons.exit_to_app)),

          const Divider(),
        ],),
      )
    );
  }
}