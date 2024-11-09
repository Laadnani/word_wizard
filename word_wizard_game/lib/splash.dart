import 'dart:async';

import 'package:flutter/material.dart';
import 'package:word_wizard_game/background.dart';
import 'package:word_wizard_game/homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds:
 3), () {
      setState(() {
        _opacity = 1.0;

      });
      Timer(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_w.png'), // Replace with your logo
          ],
        ),
      ),
    );
  }
}
