import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_wizard_game/background.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => Setting_ScreenState();
}

class Setting_ScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return  BackgroundWrapper(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Text('Settings here',
              style:
                  GoogleFonts.inknutAntiqua(fontSize: 16, color: Colors.white)),
        ],
      ),
    ));
  }
}
