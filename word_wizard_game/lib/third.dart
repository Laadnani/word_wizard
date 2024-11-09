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
          backgroundColor: Colors.transparent,
          leading:  IconButton(
                  icon: const Icon(Icons.arrow_back,
                      size: 30, color: Colors.white),
                  onPressed: () {      
                    Navigator.pop(context);
                  },
                ),
        ),
        body :
        Column(
          children: [
            Text('How to Play',  style: GoogleFonts.inknutAntiqua(
                      fontSize: 16, color: Colors.white)),
          ],
        ),
      )
    );
  }
}