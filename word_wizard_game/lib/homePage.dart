import 'package:flutter/material.dart';
import 'package:word_wizard_game/background.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  BackgroundWrapper(
      child: Scaffold(
      
        body:  SafeArea(
          
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              
              
                Image.asset('assets/images/logo_w.png'),
                
                ElevatedButton(
                                style: ElevatedButton.styleFrom(
                fixedSize:
                    const Size(250, 50), // Adjust width and height as needed
                    overlayColor: Colors.amberAccent,
                    ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/gameScreen');
                  },
                  child: const Text('Start Game'),
                ),
              ],
            )),
      )),
    );
  }
}