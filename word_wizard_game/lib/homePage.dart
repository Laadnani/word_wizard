import 'package:flutter/material.dart';
import 'package:word_wizard_game/components/tileline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar :  AppBar(
        title : const Text('Wizard'),
      ),
      body:  SingleChildScrollView(
        child: Center(
          widthFactor: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
             WordTiles(),
             const ElevatedButton(onPressed: null, child: Text('Start'))
          
            ]
          ),
        ),

        // starter packages of tiles 

        // constants needed : number of tiles, languages, 

        // keybord to show used letters 
    ));
  }
}