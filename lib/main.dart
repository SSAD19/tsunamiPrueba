import 'package:flutter/material.dart';

import 'package:tsunami_stef/Providers/provider.dart';
import 'package:tsunami_stef/Screen/screen.dart';
import 'package:tsunami_stef/Services/services.dart';
import 'package:tsunami_stef/Theme/themelight.dart';

void main() {

  runApp(MultiProvider(
    providers: [
      
      ChangeNotifierProvider(create: (_) => LoadProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => AuthServices()),
      ChangeNotifierProvider(create: (_) => UsersServices()),
      ChangeNotifierProvider(create: (_) => TextsServices()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
       ChangeNotifierProvider(create: (_) => AddTextProv())
      //TODO: USUARIOS SE CARGUEN DE UNA PARA PODER EVALUAR ALIAS EN CASO DE NUEVO USER
    ], 
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeCustomLight.temaGeneral, // TODO: cambiar depsues por un clase aparte de
      initialRoute: 'inicio',
      routes: {
        'inicio': (_) => const Inicio(),
        'login': (_) => const LoginScreen(),
        'home': (_) => const HomeScreen(),
      },
      
       );
  }
}