import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_wizard_game/background.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  Text('How to Play',
           style: GoogleFonts.inknutAntiqua(
              fontSize: 24,
              color: const Color.fromARGB(255, 230, 225, 225),
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
            
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
            const  SizedBox(height: 20),
              Text(
                'Guess the 5-letter word within a limited number of attempts',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 18,
                color: const Color.fromARGB(255, 230, 225, 225),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'After each guess, the letters in your guess will be color-coded:',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 18,
                color: const Color.fromARGB(255, 230, 225, 225),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Red: The letter is not in the word',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 18,
                    color: const Color.fromARGB(255, 230, 225, 225),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.circle, color: Colors.red),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Yellow: The letter is correct \n but in the wrong position',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 18,
                    color: const Color.fromARGB(255, 230, 225, 225),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.circle, color: Colors.yellow),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Green: The letter is correct \n and in the correct position',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 18,
                    color: const Color.fromARGB(255, 230, 225, 225),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.circle, color: Colors.green),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Tips:',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 230, 225, 225),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Use the color-coded feedback to eliminate incorrect \n letters and narrow down the possibilities.',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 18,
                color: const Color.fromARGB(255, 230, 225, 225),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Start with common letters and word patterns.',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 18,
                color: const Color.fromARGB(255, 230, 225, 225),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pay attention to letter frequency and word structure.',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 18,
                color: const Color.fromARGB(255, 230, 225, 225),
                ),
              ),
              SizedBox(height: 10),
         
                  Text(
                    'Use the hint provided ',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 18,
                    color: const Color.fromARGB(255, 230, 225, 225),
                    ),
                  ),
                const  Icon(Icons.help_outline,   color: Colors.white,
                    size: 30.0,
                  ),
                  Text(
                    '  for additional clues.',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 18,
                    color: const Color.fromARGB(255, 230, 225, 225),
                    ),
                  ),
                            
              SizedBox(height: 10),
              Text(
                'Enjoy the game and good luck!',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 18,
                color: const Color.fromARGB(255, 230, 225, 225),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
