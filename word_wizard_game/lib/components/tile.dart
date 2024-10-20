import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//// THIS IS THE COMPONENT TO STYLE THE TILES ONLY
/// FOR MANAGING THE STATE OR THE LOGIC PLEASE FIND ALL
/// IN THE Tiles on tileLine.dart

// ignore: must_be_immutable
class Tile extends StatelessWidget {

final String textEntered;


   const Tile({super.key, required this.textEntered, });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              blurRadius: 5,
              offset: const Offset(3, 3),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textEntered,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25,
                fontFamily: 'Robotomono',
                color: Colors.black,
                textBaseline: TextBaseline.alphabetic),
          ),
         
        ],
      ),
    );
  }
}