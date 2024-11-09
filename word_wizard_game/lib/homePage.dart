import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      
        body:  SingleChildScrollView(
          
          child: SafeArea(
            
            child: Column(
           
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            

                const SizedBox(height: 50),
              
                Image.asset('assets/images/logo_w.png'),
             
                const SizedBox(height: 50),
                  ElevatedButton(
              style:  ElevatedButton.styleFrom(
                elevation: 20,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                
                textStyle: const TextStyle(fontSize: 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: Colors.green[700],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child:  Text(' Start Game ',
              style: GoogleFonts.inknutAntiqua(
                    fontSize: 16, color: Colors.white),
              ),
            ),
             const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                textStyle: const TextStyle(fontSize: 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: Colors.green[700],
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              child: Text(
                'How To Play',
                style: GoogleFonts.inknutAntiqua(
                    fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                textStyle: const TextStyle(fontSize: 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                backgroundColor: Colors.green[700],
              ),
              onPressed: () {
                Null;
              },
              child: Text(
                '   Settings  \n comming soon ',
                style: GoogleFonts.inknutAntiqua(
                    fontSize: 16, color: Colors.white),
              ),
            ),

              ],
            )),
      )),
    );
  }
}