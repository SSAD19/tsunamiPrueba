import 'package:flutter/material.dart';
import 'package:tsunami_final/Providers/provider.dart';
import 'package:tsunami_final/Screen/screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoadProvider()),

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
      theme: ThemeData.dark().copyWith(), // TODO: cambiar depsues por un clase aparte de
      initialRoute: 'inicio',
      routes: {
        'inicio': (_) => const Inicio(),
      },
      
       );
  }
}