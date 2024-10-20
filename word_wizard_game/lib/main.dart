import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_wizard_game/constants.dart';
import 'package:word_wizard_game/gameprovider.dart';
import 'package:word_wizard_game/homePage.dart';
import 'package:word_wizard_game/settingScreen.dart';

void main() {
  
  runApp( ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
   @override
     Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const HomeScreen(),
      home: const HomePage(),
      routes: {
        Cts.homeScreen: (context) =>  HomePage(),
        Cts.settingScreen: (context) => const  SettingScreen(),
       

      },
    );
}

}